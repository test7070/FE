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
            //q_tables = 's';
            var q_name = "ucc";
            var q_readonly = ['txtWorker2', 'txtWorker'];
            var q_readonlys = [];
            var bbmNum = [];
            var bbsNum = [];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'Noa';
            brwCount2 = 10;
           	aPop = new Array(['txtTggno', 'lblTggno', 'tgg', 'noa,comp', 'txtTggno,txtTgg', 'tgg_b.aspx']);
           	
           	t_groupano = "";
           	q_copy = 1;
            $(document).ready(function() {
                q_bbsShow = -1;
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                q_brwCount();
                q_gt('uccga', '', 0, 0, 0, "");
            });
            
            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(0);
            }
            function mainPost() {
                q_getFormat();
                bbmMask = [['txtDatea', r_picd]];
                q_mask(bbmMask);
                if(t_groupano.length>0)
                	q_cmbParse("cmbGroupano", t_groupano);
				if (abbm[q_recno] != undefined) {
					$("#cmbGroupano").val(abbm[q_recno].groupano);
				}
                $('#btnImport').click(function(e){
                	
                });
            }
            function q_boxClose(s2) {
				var ret;
				switch (b_pop) {
					case q_name + 'fe_s':
						q_boxClose2(s2);
						break;
				}  
				b_pop = '';
			}
            function q_gtPost(t_name) {
                switch (t_name) {
                	case 'uccga':
						var as = _q_appendData("uccga", "", true);
						if (as[0] != undefined) {
							t_groupano = " @ ";
							for ( i = 0; i < as.length; i++) {
								t_groupano = t_groupano + (t_groupano.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].noa+' . '+as[i].namea;
							}
						}
						q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
						break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }
            }
            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                Unlock(1);
            }
            function btnOk() {
                Lock(1, {
                    opacity : 0
                });
                if($.trim($('#txtNoa').val()).length==0){
                	alert('請輸入物品編號。');
                	Unlock(1);
                	return
                }
                
               /* if ($('#txtDatea').val().length == 0 || !q_cd($('#txtDatea').val())) {
                    alert(q_getMsg('lblDatea') + '錯誤。');
                    Unlock(1);
                    return;
                }*/
                if (q_cur == 1) {
                    $('#txtWorker').val(r_name);
                } else
                    $('#txtWorker2').val(r_name);
                sum();
                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_drp') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
            }
            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)
                    return;
                q_box('uccfe_s.aspx', q_name + 'fe_s', "600px", "530px", q_getMsg("popSeek"));
            }
            function bbsAssign() {
                for (var j = 0; j < q_bbsCount; j++) {
                    $('#lblNo_' + j).text(j + 1);
                    if (!$('#btnMinus_' + j).hasClass('isAssign')) {
                        $('#txtTranno_' + j).bind('contextmenu', function(e) {
                            /*滑鼠右鍵*/
                            e.preventDefault();
                            var n = $(this).attr('id').replace('txtTranno_', '');
                            var t_accy = $('#txtTranaccy_' + n).val();
                            q_box("trans_tb.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";noa='" + $(this).val() + "';" + t_accy, 'trans', "95%", "95%", q_getMsg("popTrans"));
                            
                        });
                        $('#txtPrice_'+j).change(function(e){
                            sum();
                        });
                    }
                }
                _bbsAssign();
            }
            function btnIns() {
                _btnIns();
                $('#txtNoa').focus();
            }
            function btnModi() {
                if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				$('#txtNoa').attr('readonly','readonly').css('background-color','RGB(237,237,237)').css('color','green');
          		$('#txtNoa').focus();
            }
            function btnPrint() {
            	if(q_getPara('sys.project').toUpperCase()!="VU")
                	q_box("z_uccfe.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + JSON.stringify({noa:trim($('#txtNoa').val())}) + ";" + r_accy + "_" + r_cno, 'drp', "95%", "95%", m_print);
            }
            function wrServer(key_value) {
                var i;
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }
            function bbsSave(as) {
                if (!as['no2']) {
                    as[bbsKey[1]] = '';
                    return;
                }
                q_nowf();
                return true;
            }
            function sum() {
                if (!(q_cur == 1 || q_cur == 2))
                    return;
                var t_money = 0, t_moneys = 0, t_total = 0;
                for ( i = 0; i < q_bbsCount; i++) {
                   // t_money = round(q_mul(q_float('txtMount_'+i),q_float('txtPrice_'+i)),0);
                    //$('#txtTotal_'+i).val(t_money);
                    //$('#txtTranmoney_'+i).val(t_money);
                    t_money = q_float('txtTotal_'+i);
                    t_moneys += t_money;
                }
                t_plusmoney = q_float('txtPlusmoney');
                t_minusmoney = q_float('txtMinusmoney');
                t_tax = q_float('txtTax');
                t_total = t_moneys + t_tax + t_plusmoney - t_minusmoney;
                $('#txtMoney').val(t_moneys);
                $('#txtTotal').val(t_total);
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
            .tbbm .trX {
                background-color: #FFEC8B;
            }
            .tbbm .trY {
                background-color: #DAA520;
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
    <body ondragstart="return false" draggable="false"
    ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
    ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
    ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
    >
        <!--#include file="../inc/toolbar.inc"-->
        <div id="dmain">
            <div class="dview" id="dview">
                <table class="tview" id="tview">
                    <tr>
                        <td align="center" style="width:20px; color:black;"><a id="vewChk"> </a></td>
                        <td align="center" style="width:100px; color:black;"><a id="vewNoa"> </a></td>
                        <td align="center" style="width:200px; color:black;"><a id="vewProduct"> </a></td>
                    </tr>
                    <tr>
                        <td><input id="chkBrow.*" type="checkbox"/></td>
                        <td id="noa" style="text-align: center;">~noa</td>
                        <td id="product" style="text-align: center;">~product</td>
                    </tr>
                </table>
            </div>
            <div class="dbbm">
                <table class="tbbm"  id="tbbm">
                    <tr style="height:1px;">
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td class="tdZ"></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblNoa" class="lbl"> </a></td>
                        <td colspan="3"><input id="txtNoa" type="text" class="txt c1"/></td>
                    </tr>
                    <tr>
                    	<td><span> </span><a id="lblProduct" class="lbl"> </a></td>
                        <td colspan="3"><input id="txtProduct" type="text" class="txt c1"/></td>
                    </tr>
                    <tr>
                    	<td><span> </span><a id="lblUnit" class="lbl"> </a></td>
                        <td><input id="txtUnit" type="text" class="txt c1"/></td>
                        <td><span> </span><a class="lbl">進貨單價</a></td>
                        <td><input id="txtInprice" type="text" class="txt num c1"/></td>
                    </tr>
                    <tr>
                    	<td><span> </span><a class="lbl">安全數量</a></td>
                        <td><input id="txtSafemount" type="text" class="txt num c1"/></td>
                        <td><span> </span><a class="lbl">牌價</a></td>
                        <td><input id="txtSaleprice" type="text" class="txt num c1"/></td>
                    </tr>
                    <tr>
                    	<td><span> </span><a id="lblUweight" class="lbl"> </a></td>
                        <td><input id="txtUweight" type="text" class="txt num c1"/></td>
                        <td><span> </span><a class="lbl">運費型態</a></td>
                        <td><input id="txtStyleno" type="text" class="txt c1"/></td>
                    </tr>
                    <tr>
                    	<td><span> </span><a id="lblStdmount" class="lbl"> </a></td>
                        <td><input id="txtStdmount" type="text" class="txt num c1"/></td>
                        <td><span> </span><a id='lblGroupano' class="lbl"> </a></td>
						<td><select id="cmbGroupano" class="txt c1"></select></td>
                    </tr>
                    <tr>
						<td><span> </span><a id='lblTggno' class="lbl btn"> </a></td>
						<td><input id="txtTggno" type="text" class="txt c1"/></td>
						<td colspan='3'><input id="txtTgg"	type="text" class="txt c1" style="width: 95%;"></td>
                    </tr>
                    <tr>
                    	<td><span> </span><a class="lbl">備註</a></td>
                        <td colspan="3"><input id="txtMemo" type="text"  class="txt c1"/></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblWorker" class="lbl"> </a></td>
                        <td><input id="txtWorker" type="text" class="txt c1"/></td>
                        <td><span> </span><a id="lblWorker2" class="lbl"> </a></td>
                        <td><input id="txtWorker2" type="text" class="txt c1"/></td>
                    </tr>
                </table>
            </div>
        </div>
        
        <input id="q_sys" type="hidden" />
    </body>
</html>
