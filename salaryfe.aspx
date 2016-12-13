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
            var q_readonly = ['txtNoa','txtWorker','txtWorker2','txtBase','txtTotal'
            	,'txtAllowance01','txtAllowance02','txtAllowance03','txtAllowance04'
            	,'txtAllowance05','txtAllowance06','txtAllowance07','txtAllowance08'
            	,'txtAllowance09','txtAllowance10','txtAllowance11','txtAllowance12'];
            var q_readonlys = ['txtNoq','txtTotal'];
            var bbmNum = [['txtTotal',10,0,1],['txtBase',10,0,1]
            	,['txtAllowance01',10,0,1],['txtAllowance02',10,0,1],['txtAllowance03',10,0,1],['txtAllowance04',10,0,1],['txtAllowance05',10,0,1],['txtAllowance06',10,0,1]
            	,['txtAllowance07',10,0,1],['txtAllowance08',10,0,1],['txtAllowance09',10,0,1],['txtAllowance10',10,0,1],['txtAllowance11',10,0,1],['txtAllowance12',10,0,1]];
            var bbsNum = [['txtTotal',10,0,1],['txtBase',10,0,1]
            	,['txtAllowance01',10,0,1],['txtAllowance02',10,0,1],['txtAllowance03',10,0,1],['txtAllowance04',10,0,1],['txtAllowance05',10,0,1],['txtAllowance06',10,0,1]
            	,['txtAllowance07',10,0,1],['txtAllowance08',10,0,1],['txtAllowance09',10,0,1],['txtAllowance10',10,0,1],['txtAllowance11',10,0,1],['txtAllowance12',10,0,1]];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'datea';
            aPop = new Array(['txtSalesno_', 'btnSales', 'sss', 'noa,namea', 'txtSalesno_,txtSales_', 'sss_b.aspx']);
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
            	var base=0,total=0
            		,allowance01=0,allowance02=0,allowance03=0,allowance04=0
            		,allowance05=0,allowance06=0,allowance07=0,allowance08=0
            		,allowance09=0,allowance10=0,allowance11=0,allowance12=0;
            	for(var i=0;i<q_bbsCount;i++){
            		$('#txtTotal_'+i).val(q_float('txtBase_'+i)
            			+q_float('txtAllowance01_'+i)+q_float('txtAllowance02_'+i)+q_float('txtAllowance03_'+i)
            			+q_float('txtAllowance04_'+i)+q_float('txtAllowance05_'+i)+q_float('txtAllowance06_'+i)
            			+q_float('txtAllowance07_'+i)+q_float('txtAllowance08_'+i)+q_float('txtAllowance09_'+i)
            			+q_float('txtAllowance10_'+i)+q_float('txtAllowance11_'+i)+q_float('txtAllowance12_'+i));
            		base += q_float('txtBase_'+i);
            		allowance01 += q_float('txtAllowance01_'+i);
            		allowance02 += q_float('txtAllowance02_'+i);
            		allowance03 += q_float('txtAllowance03_'+i);
            		allowance04 += q_float('txtAllowance04_'+i);
            		allowance05 += q_float('txtAllowance05_'+i);
            		allowance06 += q_float('txtAllowance06_'+i);
            		allowance07 += q_float('txtAllowance07_'+i);
            		allowance08 += q_float('txtAllowance08_'+i);
            		allowance09 += q_float('txtAllowance09_'+i);
            		allowance10 += q_float('txtAllowance10_'+i);
            		allowance11 += q_float('txtAllowance11_'+i);
            		allowance12 += q_float('txtAllowance12_'+i);
            		total += q_float('txtTotal_'+i);
            	}	
            	$('#txtBase').val(FormatNumber(base));
            	$('#txtAllowance01').val(FormatNumber(allowance01));
            	$('#txtAllowance02').val(FormatNumber(allowance02));
            	$('#txtAllowance03').val(FormatNumber(allowance03));
            	$('#txtAllowance04').val(FormatNumber(allowance04));
            	$('#txtAllowance05').val(FormatNumber(allowance05));
            	$('#txtAllowance06').val(FormatNumber(allowance06));
            	$('#txtAllowance07').val(FormatNumber(allowance07));
            	$('#txtAllowance08').val(FormatNumber(allowance08));
            	$('#txtAllowance09').val(FormatNumber(allowance09));
            	$('#txtAllowance10').val(FormatNumber(allowance10));
            	$('#txtAllowance11').val(FormatNumber(allowance11));
            	$('#txtAllowance12').val(FormatNumber(allowance12));
              	$('#txtTotal').val(FormatNumber(total));
            }

            function mainPost() {
                q_getFormat();
                bbmMask = [['txtMon', r_picm]];
                q_mask(bbmMask);
                
                /*$('#txtBase').change(function(e){
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
                });*/
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
					$('#txtSalesno_' + i).bind('contextmenu', function(e) {
                        /*滑鼠右鍵*/
                        e.preventDefault();
                        var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                        $('#btnSales_' + n).click();
                    });
                    $('#txtBase_'+i).change(function(e){sum();});
                    $('#txtAllowance01_'+i).change(function(e){sum();});
                    $('#txtAllowance02_'+i).change(function(e){sum();});
                    $('#txtAllowance03_'+i).change(function(e){sum();});
                    $('#txtAllowance04_'+i).change(function(e){sum();});
                    $('#txtAllowance05_'+i).change(function(e){sum();});
                    $('#txtAllowance06_'+i).change(function(e){sum();});
                    $('#txtAllowance07_'+i).change(function(e){sum();});
                    $('#txtAllowance08_'+i).change(function(e){sum();});
                    $('#txtAllowance09_'+i).change(function(e){sum();});
                    $('#txtAllowance10_'+i).change(function(e){sum();});
                    $('#txtAllowance11_'+i).change(function(e){sum();});
                    $('#txtAllowance12_'+i).change(function(e){sum();});
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
                if (!as['salesno']) {
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
		</style>
    </head>
    <body>
        <!--#include file="../inc/toolbar.inc"-->
        <div id='dmain' style="overflow:hidden;width: 1000px;">
            <div class="dview" id="dview">
                <table class="tview" id="tview" >
                    <tr>
                        <td align="center" style="width:5%"><a id='vewChk'> </a></td>
                        <td style="display:none;">noa</td>
                        <td align="center" style="width:20%"><a id='vewMon'>月份</a></td>
                        <td align="center" style="width:20%"><a id='vewTotal'>薪資</a></td>
                    </tr>
                    <tr>
                        <td><input id="chkBrow.*" type="checkbox" style=''/></td>
                        <td style="display:none;" id='noa'>~noa</td>
                        <td align="center" id='mon'>~mon</td>
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
        <div class='dbbs' style="width: 1500px;">
            <table id="tbbs" class='tbbs' style=' text-align:center'>
                <tr style='color:white; background:#003366;' >
                    <td align="center" style="width:1%;">
                        <input class="btn" id="btnPlus" type="button" value='＋' style="font-weight: bold;" />
                    </td>
                    <td align="center" style="width:20px;"> </td>
                    <td align="center" style="width:200px;"><a>業務</a></td>
                    <td align="center" style="width:100px;"><a>本薪</a></td>
                    <td align="center" style="width:100px;"><a>全勤</a></td>
                    <td align="center" style="width:100px;"><a>無遲到</a></td>
                    <td align="center" style="width:100px;"><a>團體獎金</a></td>
                    <td align="center" style="width:100px;"><a>個人獎金</a></td>
                    <td align="center" style="width:100px;"><a>會議出勤</a></td>
                    <td align="center" style="width:100px;"><a>成交獎金</a></td>
                    <td align="center" style="width:100px;"><a>收現獎金</a></td>
                    <td align="center" style="width:100px;"><a>早收獎金</a></td>
                    <td align="center" style="width:100px;"><a>簽約獎金</a></td>
                    <td align="center" style="width:100px;"><a>職等級</a></td>
                    <td align="center" style="width:100px;"><a>報價獎金</a></td>
                    <td align="center" style="width:100px;"><a>拜訪獎金</a></td>
                    <td align="center" style="width:100px;"><a>總計</a></td>
                </tr>
                <tr style='background:#cad3ff;'>
                    <td>
                        <input class="btn" id="btnMinus.*" type="button" value='－' style=" font-weight: bold;" />
                   		<input id="txtNoq.*" type="text" style="display:none;"/> 
                    </td>
                    <td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
                    <td>
                    	<input id="txtSalesno.*" type="text" class="txt" style="float:left;width:40%;"/>
                        <input id="txtSales.*" type="text" class="txt" style="float:left;width:50%;"/>
                        <input id='btnSales.*' type="button" style="display:none;"/>
                    </td>
                    <td> <input id="txtBase.*" type="text" class="txt num" style="width:95%;"/></td>
                    <td> <input id="txtAllowance01.*" type="text" class="txt num" style="width:95%;"/></td>
                    <td> <input id="txtAllowance02.*" type="text" class="txt num" style="width:95%;"/></td>
                    <td> <input id="txtAllowance03.*" type="text" class="txt num" style="width:95%;"/></td>
                    <td> <input id="txtAllowance04.*" type="text" class="txt num" style="width:95%;"/></td>
                    <td> <input id="txtAllowance05.*" type="text" class="txt num" style="width:95%;"/></td>
                    <td> <input id="txtAllowance06.*" type="text" class="txt num" style="width:95%;"/></td>
                    <td> <input id="txtAllowance07.*" type="text" class="txt num" style="width:95%;"/></td>
                    <td> <input id="txtAllowance08.*" type="text" class="txt num" style="width:95%;"/></td>
                    <td> <input id="txtAllowance09.*" type="text" class="txt num" style="width:95%;"/></td>
                    <td> <input id="txtAllowance10.*" type="text" class="txt num" style="width:95%;"/></td>
                    <td> <input id="txtAllowance11.*" type="text" class="txt num" style="width:95%;"/></td>
                    <td> <input id="txtAllowance12.*" type="text" class="txt num" style="width:95%;"/></td>
                    <td> <input id="txtTotal.*" type="text" class="txt num" style="width:95%;"/></td>
                </tr>
            </table>
        </div>
        <input id="q_sys" type="hidden" />
    </body>
</html>