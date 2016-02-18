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
            q_tables = 's';
            var q_name = "rc2t";
            var decbbs = ['money', 'total', 'mount', 'price', 'sprice', 'dime', 'width', 'lengthb', 'weight2'];
            var decbbm = ['payed', 'unpay', 'usunpay', 'uspayed', 'ustotal', 'discount', 'money', 'tax', 'total', 'weight', 'floata', 'mount', 'price', 'tranmoney', 'totalus'];
            var q_readonly = ['txtNoa'];
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
                bbmMask = [['txtDatea', r_picd], ['txtMon', r_picm]];
                q_mask(bbmMask);
                bbmNum = [];
                bbsNum = [['txtMount', 15, q_getPara('rc2.mountPrecision'), 1],['txtWeight', 15, q_getPara('rc2.weightPrecision'), 1], ['txtPrice', 15, q_getPara('rc2.pricePrecision'), 1], ['txtTotal', 15, 0, 1], ['txtDiscount', 5, 2, 1], ['txtCounta', 5, 0, 1]];
                
             	$('#btnImport').click(function(e){
             		var t_rc2no = $.trim($('#txtRc2no').val());
                	var t_rc2noq = $.trim($('#txtRc2noq').val());
                	if(t_rc2no.length==0 || t_rc2noq.length==0){
                		alert('請輸入進貨單號。');
                		return;
                	}
                	Lock(1, {
	                    opacity : 0
	                });
                	q_func('qtxt.query.rc2t', 'rc2t.txt,import,' + encodeURI(t_rc2no) + ';' + encodeURI(t_rc2noq)); 	
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
                var t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')],['txtDatea', q_getMsg('lblDatea')], ['txtTggno', q_getMsg('lblTgg')], ['txtCno', q_getMsg('lblAcomp')]]);
                // 檢查空白
                if (t_err.length > 0) {
                    alert(t_err);
                    return;
                }
                
                sum();
                if (q_cur == 1)
                    $('#txtWorker').val(r_name);
                if (q_cur == 2)
                    $('#txtWorker2').val(r_name);
                    
           		save();
            }
            function q_funcPost(t_func, result) {
                switch(t_func) {
                	case 'qtxt.query.rc2t':
                        var as = _q_appendData("tmp0", "", true, true);
                        if (as[0] != undefined) {
                            q_gridAddRow(bbsHtm, 'tbbs', 'txtCustno,txtCust,txtUnit,txtMount,txtWeight,txtPrice,txtMoney,txtVccno,txtVccnoq'
                        	, as.length, as, 'custno,cust,unit,mount,weight,price,total,vccno,vccnoq', '','');
                        } else {
                            alert('無資料!');

                        }
                        Unlock(1);
                        break;
                    default:
                       break;
                }
            }
            function save(){
            	var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
                if (s1.length == 0 || s1 == "AUTO")
                    q_gtnoa(q_name, replaceAll($('#txtDatea').val(), '/', ''));
                else
                    wrServer(s1);
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
                q_box('rc2tfe_s.aspx', q_name + '_s', "500px", "500px", q_getMsg("popSeek"));
            }

            function bbsAssign() {
                for (var j = 0; j < (q_bbsCount == 0 ? 1 : q_bbsCount); j++) {
                	$('#lblNo_'+j).text(j+1);
                    if (!$('#btnMinus_' + j).hasClass('isAssign')) {
                        
                    }
                }
                _bbsAssign();
            }

            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtDatea').val(q_date());
                $('#txtDatea').focus();
                
                var rc2no = q_getId(0)[3].replace(/rc2no='(.*)' and rc2noq='(.*)'/g,'$1');
                var rc2noq = q_getId(0)[3].replace(/rc2no='(.*)' and rc2noq='(.*)'/g,'$2');
                $('#txtRc2no').val(rc2no);
                $('#txtRc2noq').val(rc2noq);
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
                width: 95%;
                float: left;
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
        <div id='dmain'>
            <div class="dview" id="dview">
                <table class="tview" id="tview" >
                    <tr>
                        <td align="center" style="width:5%"><a id='vewChk'> </a></td>
                        <td align="center" style="width:20%"><a id='vewDatea'>日期</a></td>
                        <td align="center" style="width:25%"><a id='vewUno'>批號</a></td>
                    </tr>
                    <tr>
                        <td><input id="chkBrow.*" type="checkbox" style=''/></td>
                        <td align="center" id='datea'>~datea</td>
                        <td align="center" id='uno'>~uno</td>
                    </tr>
                </table>
            </div>
            <div class='dbbm'>
                <table class="tbbm" id="tbbm">
                    <tr>
                        <td><span> </span><a id='lblNoa' class="lbl">電腦編號</a></td>
                        <td><input id="txtNoa" type="text" class="txt c1"/></td>
                        <td><span> </span><a id='lblDatea' class="lbl">日期</a></td>
                        <td><input id="txtDatea" type="text" class="txt c1"/></td>
                        <td><span> </span><a id='lblUno' class="lbl">批號</a></td>
                        <td><input id="txtUno" type="text" class="txt c1"/></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id='lblRc2no' class="lbl">進貨單號</a></td>
                        <td colspan="2">
                        	<input id="txtRc2no" type="text" class="txt" style="width:70%;"/>
                        	<input id="txtRc2noq" type="text" class="txt" style="width:25%;"/>
                    	</td>
                    	<td><span> </span><a id='lblCustno' class="lbl">客戶編號</a></td>
                        <td>
                        	<input id="txtCustno" type="text" class="txt c1"/>
                        </td>
                    	<td><input type="button" id="btnImport" value="匯入" /></td>
                    </tr>
                </table>
            </div>
        </div>
        <div class='dbbs'>
            <table id="tbbs" class='tbbs'>
                <tr style='color:white; background:#003366;' >
                    <td align="center" style="width:1%;">
                        <input class="btn" id="btnPlus" type="button" value='＋' style="font-weight: bold;" />
                    </td>
                    <td align="center" style="width:20px;"> </td>
                    <td align="center" style="width:100px;"><a>客戶編號</a></td>
                    <td align="center" style="width:100px;"><a>公司簡稱</a></td>
                    <td align="center" style="width:100px;"><a>單位</a></td>
                    <td align="center" style="width:100px;"><a>數量</a></td>
                    <td align="center" style="width:100px;"><a>重量</a></td>
                    <td align="center" style="width:100px;"><a>單價</a></td>
                    <td align="center" style="width:100px;"><a>金額</a></td>
                    <td align="center" style="width:100px;"><a>出貨單號</a></td>
                </tr>
                <tr style='background:#cad3ff;'>
                    <td>
                        <input class="btn" id="btnMinus.*" type="button" value='－' style=" font-weight: bold;" />
                        <input id="txtNoq.*" type="text" style="display:none;"/>
                    </td>
                    <td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
                    <td><input id="txtCustno.*" type="text" class="txt c1"/></td>
                    <td><input id="txtCust.*" type="text" class="txt c1"/></td>
                    <td><input id="txtUnit.*" type="text" class="txt c1"/></td>
                    <td><input id="txtMount.*" type="text" class="txt c1 num"/></td>
                	<td><input id="txtWeight.*" type="text" class="txt c1 num"/></td>
                	<td><input id="txtPrice.*" type="text" class="txt c1 num"/></td>
                	<td><input id="txtMoney.*" type="text" class="txt c1 num"/></td>
                	<td>
                		<input id="txtVccno.*" type="text" class="txt" style="width:70%; float:left;"/>
                		<input id="txtVccnoq.*" type="text" class="txt" style="width:20%; float:left;"/>
            		</td>
                </tr>
            </table>
        </div>
        <input id="q_sys" type="hidden" />
    </body>
</html>