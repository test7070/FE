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
            var q_name = "salexambase";
            var decbbs = [];
            var decbbm = [];
            var q_readonly = ['txtWorker','txtWorker2'];
            var q_readonlys = ['txtNoq'];
            var bbmNum = [];
            var bbsNum = [['txtWeight',10,0,1]];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            aPop = new Array();
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
            }

            function mainPost() {
                q_getFormat();
                q_mask(bbmMask);
                
                $('#txtNoa').change(function(e) {
                	var t_noa = $.trim($(this).val());
                	if(t_noa.length>0){
                		t_where = "where=^^ noa='" + t_noa + "'^^";
						q_gt('salexambase', t_where, 0, 0, 0, "noa_change", r_accy);	
                	}
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
                	case 'noa_change':
						var as = _q_appendData("salexambase", "", true);
						if (as[0] != undefined) {
							alert('已存在 ' + as[0].noa + ' ' + as[0].description);
						}
						break;
					case 'noa_btnOk':
						var as = _q_appendData("salexambase", "", true);
						if (as[0] != undefined) {
							alert('已存在 ' + as[0].noa + ' ' + as[0].description);
							Unlock(1);
							return;
						} else {
							wrServer($('#txtNoa').val());
						}
						break;
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
                var t_noa = $.trim($('#txtNoa').val());
	        	if(t_noa.length==0){
	        		alert('請輸入編號。');
	        		return;
	        	}
                if (q_cur == 1)
                    $('#txtWorker').val(r_name);
                if (q_cur == 2)
                    $('#txtWorker2').val(r_name);
                
                if(q_cur==1){
                	t_where = "where=^^ noa='" + t_noa + "'^^";
					q_gt('salexambase', t_where, 0, 0, 0, "noa_change", r_accy);	
                }else{
                	wrServer(t_noa);
                }
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
                q_box('salexambase_s.aspx', q_name + '_s', "500px", "500px", q_getMsg("popSeek"));
            }

            function bbsAssign() {
                for (var i = 0; i < (q_bbsCount == 0 ? 1 : q_bbsCount); i++) {
                	$('#lblNo_'+i).text(i+1);
                    if ($('#btnMinus_' + i).hasClass('isAssign'))
						continue;
					$('#txtSssno_' + i).bind('contextmenu', function(e) {
                        /*滑鼠右鍵*/
                        e.preventDefault();
                        var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                        $('#btnSss_' + n).click();
                    });
                }
                _bbsAssign();
            }

            function btnIns() {
                _btnIns();
                $('#txtNoa').val('').focus();
            }
			var guid = (function() {
				function s4() {return Math.floor((1 + Math.random()) * 0x10000).toString(16).substring(1);}
				return function() {return s4() + s4() + '-' + s4() + '-' + s4() + '-' +s4() + '-' + s4() + s4() + s4();};
			})();
            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
            	$('#txtNoa').attr('readonly','readonly').css('color','green');
            }

            function btnPrint() {
				q_box("z_salaryfe.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + JSON.stringify({noa:trim($('#txtNoa').val())}) + ";" + r_accy + "_" + r_cno, 'salaryfe', "95%", "95%", m_print);
			}

            function wrServer(key_value) {
                var i;
                $('#txtNoa').val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (!as['description']) {
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
                width: 800px;
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
                        <td align="center" style="width:20%"><a id='vewTypea'>類型</a></td>
                        <td align="center" style="width:20%"><a id='vewDescription'>描述</a></td>
                    </tr>
                    <tr>
                        <td><input id="chkBrow.*" type="checkbox" style=''/></td>
                        <td style="display:none;" id='noa'>~noa</td>
                        <td align="center" id='typea'>~typea</td>
                        <td align="center" id='description'>~description</td>
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
                        <td><span> </span><a id='lblTypea' class="lbl">類型</a></td>
                        <td><input id="txtTypea" type="text" list="listType" class="txt c1"/></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id='lblDescription' class="lbl">描述</a></td>
                        <td colspan="5"><input id="txtDescription" type="text" class="txt c1"/></td>
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
        <div class='dbbs'>
            <table id="tbbs" class='tbbs' style=' text-align:center'>
                <tr style='color:white; background:#003366;' >
                    <td align="center" style="width:1%;">
                        <input class="btn" id="btnPlus" type="button" value='＋' style="font-weight: bold;" />
                    </td>
                    <td align="center" style="width:20px;"> </td>
                    <td align="center" style="width:300px;"><a>描述</a></td>
                    <td align="center" style="width:80px;"><a>權重</a></td>
                    <td align="center" style="width:150px;"><a>備註 </a></td>
                </tr>
                <tr style='background:#cad3ff;'>
                    <td>
                        <input class="btn" id="btnMinus.*" type="button" value='－' style=" font-weight: bold;" />
                   		<input id="txtNoq.*" type="text" style="display:none;"/> 
                    </td>
                    <td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
                    <td> <input id="txtDescription.*" type="text" class="txt" style="width:95%;"/></td>
                    <td> <input id="txtWeight.*" type="text" class="txt num" style="width:95%;"/></td>
                    <td> <input id="txtMemo.*" type="text" class="txt" style="width:95%;"/></td>
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