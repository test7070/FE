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
            this.errorHandler = null;
            function onPageError(error) {
                alert("An error occurred:\r\n" + error.Message);
            }
            q_tables = 's';
            var q_name = "drp";
            var q_readonly = ['txtWorker2', 'txtWorker','txtNoa'];
            var q_readonlys = [];
            var bbmNum = [['txtPrice',10,0,1]];
            var bbsNum = [['txtPrice',10,0,1]];
            var bbmMask = [];
            var bbsMask = [['txtOuttime','99:99'],['txtBacktime','99:99']];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'Datea';
            q_desc = 1;
            brwCount2 = 5;
            aPop = new Array(['txtCustno', 'lblCust', 'cust', 'noa,comp,nick', 'txtCustno,txtComp,txtNick', 'cust_b.aspx']
            , ['txtCno', 'lblAcomp', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx']
            , ['txtStraddrno','','addr2','noa,addr','txtStraddrno,txtStraddr','addr2_b.aspx']
            , ['txtEndaddrno','','addr2','noa,addr','txtEndaddrno,txtEndaddr','addr2_b.aspx']
            , ['txtBoatno', 'lblBoat', 'boat', 'noa,boat', 'txtBoatno,txtBoat', 'boat_b.aspx']
            , ['txtDriverno', 'lblDriver', 'driver', 'noa,namea','txtDriverno,txtDriver', 'driver_b.aspx']);
            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
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
                
                $('#btnImport').click(function(e){
                	var t_date = $('#txtDatea').val();
                	var t_driverno = $('#txtDriverno').val();
                	if(t_date.length==0){
                		alert('請輸入日期。');
                		return;
                	}
                	if(t_driverno.length==0){
                		alert('請輸入司機。');
                		return;
                	}
                	q_func('qtxt.query.drp', 'drp.txt,import,' + encodeURI(t_date) + ';' + encodeURI(t_driverno)); 	
                });
            }
            function q_funcPost(t_func, result) {
                switch(t_func) {
                    case 'qtxt.query.drp':
                        var as = _q_appendData("tmp0", "", true, true);
                        if (as[0] != undefined) {
                           /* q_gridAddRow(bbsHtm, 'tbbs', 'txtMoney,txtTranmoney,txtTranmoney2,txtOuttime,txtBacktime,txtMount,txtCost,txtWeight,txtPrice'
                        	, as.length, as, 'money,tranmoney,tranmoney2,outtime,backtime,mount,cost,weight,price', '','');
                        	*/
                        	q_gridAddRow(bbsHtm, 'tbbs', 'txtCarno,txtMoney'
                        	, as.length, as, 'carno,money', '','');
                        } else {
                            alert('無資料!');

                        }
                        Unlock(1);
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
                if ($('#txtDatea').val().length == 0 || !q_cd($('#txtDatea').val())) {
                    alert(q_getMsg('lblDatea') + '錯誤。');
                    Unlock(1);
                    return;
                }
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
                q_box('drp_s.aspx', q_name + '_s', "600px", "530px", q_getMsg("popSeek"));
            }
            function bbsAssign() {
                for (var j = 0; j < q_bbsCount; j++) {
                    $('#lblNo_' + j).text(j + 1);
                    if (!$('#btnMinus_' + j).hasClass('isAssign')) {
                       /* $('#txtTranno_' + j).bind('contextmenu', function(e) {
                            //滑鼠右鍵
                            e.preventDefault();
                            var n = $(this).attr('id').replace('txtTranno_', '');
                            var t_accy = $('#txtTranaccy_' + n).val();
                            q_box("trans_tb.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";noa='" + $(this).val() + "';" + t_accy, 'trans', "95%", "95%", q_getMsg("popTrans"));
                            
                        });*/
                        $('#txtPrice_'+j).change(function(e){
                            sum();
                        });
                        
                        $('#txtOuttime_'+j).focusout(function(e){
                            sum();
                        });
                        $('#txtBacktime_'+j).focusout(function(e){
                            sum();
                        });
                    }
                }
                _bbsAssign();
            }
            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtDatea').focus();
            }
            function btnModi() {
                if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				$('#txtDatea').focus();
            }
            function btnPrint() {
                q_box("z_drpp.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + JSON.stringify({noa:trim($('#txtNoa').val())}) + ";" + r_accy + "_" + r_cno, 'drp', "95%", "95%", m_print);
            }
            function wrServer(key_value) {
                var i;
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }
            function bbsSave(as) {
                if (!as['carno']) {
                    as[bbsKey[1]] = '';
                    return;
                }
                q_nowf();
                return true;
            }
            function sum() {
                if (!(q_cur == 1 || q_cur == 2))
                    return;
                var t_money = 0, t_moneys = 0, t_total = 0,t_outdate,t_backdate,t_h,t_m,t_s;
                for ( i = 0; i < q_bbsCount; i++) {
                    t_moneys = q_float('txtTotal_'+i);
                    t_money += t_moneys;
                	//-------------------------------------------
                	if($('#txtBacktime_'+i).val()>'12:00' && $('#txtBacktime_'+i).val()<'13:00' )
                		$('#txtBacktime_'+i).val('12:00');                 
                		
                	if($('#txtDatea').val().length>0 && $('#txtOuttime_'+i).val().length>0 && $('#txtBacktime_'+i).val().length>0){
                		t_outdate=new Date();
                		t_outdate.setFullYear(parseInt($('#txtDatea').val().substring(0,3))+1911);
                		t_outdate.setMonth(parseInt($('#txtDatea').val().substring(5,6))-1);
                		t_outdate.setDate(parseInt($('#txtDatea').val().substring(8,9)));
                		t_outdate.setHours(parseInt($('#txtOuttime_'+i).val().substring(0,2)));
                		t_outdate.setMinutes(parseInt($('#txtOuttime_'+i).val().substring(3,5)));
                		t_backdate=new Date();
                		t_backdate.setFullYear(parseInt($('#txtDatea').val().substring(0,3))+1911);
                		t_backdate.setMonth(parseInt($('#txtDatea').val().substring(5,6))-1);
                		t_backdate.setDate(parseInt($('#txtDatea').val().substring(8,9)));
                		t_backdate.setHours(parseInt($('#txtBacktime_'+i).val().substring(0,2)));
                		t_backdate.setMinutes(parseInt($('#txtBacktime_'+i).val().substring(3,5)));

                		t_s = t_backdate.getTime()-t_outdate.getTime();
                		t_m = Math.floor(t_s/60000);
                		t_h = round(t_m/60,2);
                		//跨中午時間
                		if($('#txtOuttime_'+i).val()<'12:00' && $('#txtBacktime_'+i).val()>'13:00')
                			t_h--;
                		$('#txtMount_'+i).val(t_h);
                	}else{
                		$('#txtMount_'+i).val('');
                	}
                	//-------------------------------------------
                }
                t_plusmoney = q_float('txtPlusmoney');
                t_minusmoney = q_float('txtMinusmoney');
                t_tax = q_float('txtTax');
                t_total = t_money + t_tax + t_plusmoney - t_minusmoney;
                $('#txtMoney').val(t_money);
                $('#txtTotal').val(t_total);
            }
            function refresh(recno) {
                _refresh(recno);
            }
            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                
                if(t_para)
                	$('#btnImport').attr('disabled', 'disabled');
                else
                	$('#btnImport').removeAttr('disabled');
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
                width: 200px;
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
                        <td align="center" style="width:80px; color:black;"><a id="vewDatea"> </a></td>
                        <td align="center" style="width:100px; color:black;"><a id="vewDriver"> </a></td>
                    </tr>
                    <tr>
                        <td><input id="chkBrow.*" type="checkbox"/></td>
                        <td id="datea" style="text-align: center;">~datea</td>
                        <td id="driver" style="text-align: center;">~driver</td>
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
                        <td></td>
                        <td class="tdZ"></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblNoa" class="lbl"> </a></td>
                        <td><input id="txtNoa" type="text" class="txt c1"/></td>
                        <td></td>
                        <td></td>
                        <td><input type="button" id="btnImport" value="匯入" class="txt c1"></td>
                    </tr>
                    <tr>
                    	<td><span> </span><a id="lblDatea" class="lbl"> </a></td>
                        <td><input id="txtDatea" type="text"  class="txt c1"/></td>
                        <td><span> </span><a id="lblDriver" class="lbl btn"> </a></td>
                        <td colspan="2">
                        <input id="txtDriverno" type="text"  style='width:50%; float:left;'/>
                        <input id="txtDriver" type="text"  style='width:50%; float:left;'/>
                        </td>
                    </tr>
                    <tr>
                    	<td><span> </span><a id="lblPrice" class="lbl"> </a></td>
                        <td><input id="txtPrice" type="text"  class="txt c1 num" /></td>
                    </tr>
                    <tr>
                    	<td><span> </span><a id="lblMemo" class="lbl"> </a></td>
                        <td colspan="4"><input id="txtMemo" type="text"  class="txt c1"/></td>
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
        <div class='dbbs'>
            <table id="tbbs" class='tbbs' style=' text-align:center'>
                <tr style='color:white; background:#003366;' >
                    <td  align="center" style="width:30px;">
                    <input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
                    </td>
                    <td align="center" style="width:20px;"></td>
                    <td align="center" style="width:100px;"><a id='lblCarno_s'> </a></td>
                    <td align="center" style="width:100px;"><a id='lblMoney_s'> </a></td>
                    <td align="center" style="width:100px;"><a id='lblTranmoney_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblTranmoney2_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblOuttime_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblBacktime_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblMount_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblCost_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblWeight_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblPrice_s'> </a></td>
                </tr>
                <tr style='background:#cad3ff;'>
                    <td align="center">
	                    <input class="btn" id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
	                    <input id="txtNoq.*" type="text" style="display: none;"/>
	                    <input id="txtAccy.*" type="text" style="display: none;"/>
	                    <input id="txtTablea.*" type="text" style="display: none;"/>
	                    <input id="txtNo2.*" type="text" style="display: none;"/>
                    </td>
                    <td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
                    <td><input type="text" id="txtCarno.*" style="width:95%;"/></td>
                    <td><input type="text" id="txtMoney.*" style="width:95%;text-align: right;"/></td>
                    <td><input type="text" id="txtTranmoney.*" style="width:95%;text-align: right;"/></td>
                    <td><input type="text" id="txtTranmoney2.*" style="width:95%;text-align: right;"/></td>
                    <td><input type="text" id="txtOuttime.*" style="width:95%;text-align: center;"/></td>
                    <td><input type="text" id="txtBacktime.*" style="width:95%;text-align: center;"/></td>
                    <td><input type="text" id="txtMount.*" style="width:95%;text-align: right;"/></td>
                    <td><input type="text" id="txtCost.*" style="width:95%;text-align: right;"/></td>
                    <td><input type="text" id="txtWeight.*" style="width:95%;text-align: right;"/></td>
                    <td><input type="text" id="txtPrice.*" style="width:95%;text-align: right;"/></td>
                </tr>
            </table>
        </div>
        <input id="q_sys" type="hidden" />
    </body>
</html>
