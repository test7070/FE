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
            var q_name = "vccpr";
            var q_readonly = ['txtWorker2', 'txtWorker','txtNoa','txtProfit','txtTotal','txtSprice','txtWcost','txtTranmoney','txtTranmoney2','txtInte','txtCost_a','txtCost_b','txtCash'];
            var q_readonlys = [];
            var bbmNum = [];
            var bbsNum = [['txtPrice',10,2,1]];
            var bbmMask = [['txtBdate', '999/99/99'],['txtEdate', '999/99/99']];
            var bbsMask = [['txtDatea', '999/99/99']];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'Noa';
            q_desc = 1;
            brwCount2 = 10;
            q_bbsLen = 20;
            aPop = new Array(['txtCustno', 'lblCust', 'cust', 'noa,comp,nick', 'txtCustno,txtCust,txtCust', 'cust_b.aspx']
            , ['txtSalesno', 'lblSales', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx']
            , ['txtCno', 'lblAcomp', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx']
            , ['txtStraddrno','','addr2','noa,addr','txtStraddrno,txtStraddr','addr2_b.aspx']
            , ['txtEndaddrno','','addr2','noa,addr','txtEndaddrno,txtEndaddr','addr2_b.aspx']
            , ['txtBoatno', 'lblBoat', 'boat', 'noa,boat', 'txtBoatno,txtBoat', 'boat_b.aspx']
            , ['txtProductno_', 'btnProduct_', 'ucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucc_b.aspx']);
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
              //  bbmMask = [['txtDatea', r_picd]];
                q_mask(bbmMask);
                
                $('#txtBdate').val(q_date());
                $('#txtEdate').val(q_date());
                $('#btnImport').click(function(e){
                	var t_bdate = $('#txtBdate').val();
                	var t_edate = $('#txtEdate').val();
                	var t_custno = $('#txtCustno').val();
                	var t_salesno = $('#txtSalesno').val();
                	if(t_bdate.length==0 || t_edate.length==0){
                		alert('請輸入日期。');
                		return;
                	}
                	q_func('qtxt.query.vccpr', 'vccpr.txt,import,' + encodeURI(t_bdate) + ';' + encodeURI(t_edate)+ ';' + encodeURI(t_custno)+ ';' + encodeURI(t_salesno)); 	
                });
            }
            function q_funcPost(t_func, result) {
                switch(t_func) {
                    case 'qtxt.query.vccpr_vcc':
                        //
                        break;
                    case 'qtxt.query.vccpr':
                        var as = _q_appendData("tmp0", "", true, true);
                        if (as[0] != undefined) {
                            q_gridAddRow(bbsHtm, 'tbbs', 'txtTypea,txtDatea,txtCustno,txtCust,txtNick,txtLengthb,txtUnit,txtMount,txtWeight,txtApv,txtTranmoney,txtPrice,txtHprice,txtPprice,txtLprice,txtWcost,txtSprice,txtSprice2,txtTranmoney2,txtTrantype,txtTranaddr,txtTranmoney3,txtAccy,txtTablea,txtVccno,txtVccnoq,txtWorker,txtProfit,txtTotal,txtProductno,txtProduct,txtInte,txtDaya,txtRate,txtCash'
                        	, as.length, as, 'typea,datea,custno,cust,nick,lengthb,unit,mount,weight,apv,tranmoney,price,hprice,pprice,lprice,wcost,sprice,sprice2,tranmoney2,trantype,tranaddr,tranmoney3,accy,tablea,vccno,vccnoq,worker,profit,total,productno,product,inte,daya,rate,cash', '','');
                        	sum();
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
                q_func('qtxt.query.vccpr_vcc', 'vccpr.txt,vccpr_vcc,' + encodeURI($('#txtNoa').val())); 
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
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_vccpr') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
            }
            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)
                    return;
                q_box('vccpr_s.aspx', q_name + '_s', "600px", "530px", q_getMsg("popSeek"));
            }
            function bbsAssign() {
                for (var j = 0; j < q_bbsCount; j++) {
                    $('#lblNo_' + j).text(j + 1);
                    if (!$('#btnMinus_' + j).hasClass('isAssign')) {
                        $('#lblNo_' + j).bind('contextmenu', function(e) {
                            /*滑鼠右鍵*/
                            e.preventDefault();
                            var n = $(this).attr('id').replace('lblNo_', '');
                            var t_accy = $('#txtAccy_' + n).val();
                            var t_tablea = $('#txtTablea_' + n).val();
                            var t_noa =  $('#txtVccno_' + n).val();
                            q_box("vccfe.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";noa='" + t_noa + "';" + t_accy, t_tablea, "95%", "95%", q_getMsg("popVcc"));
                        });
                        $('#txtPrice_'+j).change(function(e){
                            sum();
                        });
                        $('#txtProductno_' + j).bind('contextmenu', function(e) {
							/*滑鼠右鍵*/
							e.preventDefault();
							var n = $(this).attr('id').replace('txtProductno_', '');
							$('#btnProduct_'+n).click();
						});
                    }
                }
                _bbsAssign();
            }
            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtDatea').val(q_date).focus();
            }
            function btnModi() {
                if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				$('#txtDatea').focus();
            }
            function btnPrint() {
                q_box("z_vccprp.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + JSON.stringify({noa:trim($('#txtNoa').val())}) + ";" + r_accy + "_" + r_cno, 'vccpr', "95%", "95%", m_print);
            }
            function wrServer(key_value) {
                var i;
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }
            function bbsSave(as) {
                if (!as['vccno']) {
                    as[bbsKey[1]] = '';
                    return;
                }
                q_nowf();
                return true;
            }
            function sum() {
                if (!(q_cur == 1 || q_cur == 2))
                    return;
                var t_cash = 0, t_profit=0, t_inte = 0, t_tranmoney=0, t_tranmoney2=0,t_spricemoney=0,t_wcost=0,t_total=0;
                for ( i = 0; i < q_bbsCount; i++) {
                	t_type = ($('#txtTypea_'+i).val()=='1'?1:-1);
                    t_cash += q_float('txtCash_'+i);
                    t_profit += q_float('txtProfit_'+i);
                    t_inte += q_float('txtInte_'+i);
                    t_tranmoney = q_add(t_tranmoney,q_float('txtTranmoney_'+i)*t_type);
                    t_tranmoney2 = q_add(t_tranmoney2,(q_float('txtTranmoney2_'+i)+q_float('txtTranmoney3_'+i))*t_type);

                    t_mount = $('#txtUnit_'+i).val().toUpperCase()=='KG' || $('#txtUnit_'+i).val().length==0?q_float('txtWeight_'+i):q_float('txtMount_'+i);
                    t_wcost = q_add(t_wcost, round(q_mul(t_mount,q_float('txtWcost_'+i)),0)*t_type);
                    
                    t_sprice = q_float('txtSprice2_'+i)>0?q_float('txtSprice2_'+i):q_float('txtSprice_'+i);
                    t_spricemoney = q_add(t_spricemoney, round(q_mul(t_mount,t_sprice),0)*t_type)
                
                	t_total = q_add(t_total,q_float('txtTotal_'+i)*t_type);
                }
                $('#txtCash').val(t_cash);
                $('#txtInte').val(t_inte);
                $('#txtTranmoney').val(t_tranmoney);
                $('#txtTranmoney2').val(t_tranmoney2);
                $('#txtWcost').val(t_wcost);
                $('#txtSprice').val(t_spricemoney);
                $('#txtTotal').val(t_total);
                
                t_profit = t_total - t_spricemoney - t_tranmoney - t_tranmoney2 - t_wcost - t_inte;
                
                $('#txtProfit').val(t_profit);
            }
            function refresh(recno) {
                _refresh(recno);
            }
            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                if(t_para){
                	$('#txtBdate').datepicker('destroy');
                	$('#txtEdate').datepicker('destroy');
                	
                }else{
                	$('#txtBdate').datepicker();
                	$('#txtEdate').datepicker();
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
                overflow:hidden;
                width: 100%;
            }
            .dview {
                float: left;
                width: 20%;
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
                width: 80%;
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
                width: 1500px;
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
                        <td align="center" style="width:120px; color:black;"><a id="vewDate">出貨日期</a></td>
                        <td align="center" style="width:80px; color:black;"><a id="vewCust"> </a></td>
                        <td align="center" style="width:80px; color:black;"><a id="vewSales"> </a></td>
                    </tr>
                    <tr>
                        <td><input id="chkBrow.*" type="checkbox"/></td>
                        <td id="bdate edate" style="text-align: center;">~bdate ~edate</td>
                        <td id="cust" style="text-align: center;">~cust</td>
                        <td id="sales" style="text-align: center;">~sales</td>
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
                        <td><span> </span><a id="lblDatea" class="lbl">登錄日期</a></td>
                        <td><input id="txtDatea" type="text" class="txt c1"/></td>
                        <td><input type="button" id="btnImport" value="匯入" class="txt c1"></td>
                    </tr>
                    <tr>
                    	<td><span> </span><a id="lblBdate" class="lbl">出貨日期</a></td>
                        <td colspan="2">
                        	<input id="txtBdate" type="text" class="txt" style="width:45%;"/>
                        	<span style="float:left; display:block; width:20px;">～</span>
                        	<input id="txtEdate" type="text" class="txt" style="width:45%;"/>
                        </td>
                    </tr>
                    <tr>
                    	<td><span> </span><a id="lblCust" class="lbl">客戶</a></td>
                        <td>
                        	<input id="txtCustno" type="text" class="txt" style="float:left;width:50%;"/>
                        	<input id="txtCust" type="text" class="txt" style="float:left;width:50%;"/>
                        </td>
                    	<td><span> </span><a id="lblSales" class="lbl">業務</a></td>
                        <td>
                        	<input id="txtSalesno" type="text" class="txt" style="float:left;width:50%;"/>
                        	<input id="txtSales" type="text" class="txt" style="float:left;width:50%;"/>
                        </td>
                    </tr>
                    <tr>
                    	<td><span> </span><a id="lblProfit" class="lbl">毛利合計</a></td>
                        <td><input id="txtProfit" type="text" class="txt c1 num"/></td>
                        <td><span> </span><a id="lblTotal" class="lbl">銷售合計</a></td>
                        <td><input id="txtTotal" type="text" class="txt c1 num"/></td>
                    </tr>
                    <tr>
                      	<td><span> </span><a id="lblSprice" class="lbl">基價成本</a></td>
                        <td><input id="txtSprice" type="text" class="txt c1 num"/></td>
                        <td><span> </span><a id="lblWcost" class="lbl">加工費</a></td>
                        <td><input id="txtWcost" type="text" class="txt c1 num"/></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblTranmoney" class="lbl">運費</a></td>
                        <td><input id="txtTranmoney" type="text" class="txt c1 num"/></td>
                        <td><span> </span><a id="lblTranmoney2" class="lbl">補運費</a></td>
                        <td><input id="txtTranmoney2" type="text" class="txt c1 num"/></td>
                    </tr>
                    <td><span> </span><a id="lblInte" class="lbl">預估利息</a></td>
                        <td><input id="txtInte" type="text" class="txt c1 num"/>
                    </td>
                    <tr>
                        <td><span> </span><a id="lblCost_a" class="lbl">佣金合計</a></td>
                        <td><input id="txtCost_a" type="text" class="txt c1 num"/></td>
                        <td><span> </span><a id="lblCost_b" class="lbl">其他費用</a></td>
                        <td><input id="txtCost_b" type="text" class="txt c1 num"/></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblCash" class="lbl">資金使用率</a></td>
                        <td><input id="txtCash" type="text" class="txt c1 num"/></td>
                    </tr>
                    <tr>
                    	<td><span> </span><a id="lblMemo" class="lbl"></a></td>
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
                    <td align="center" style="width:200px;"><a id='lblDatea_s'> </a></td>
  					<td align="center" style="width:150px;"><a id='lblCust_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblLengthb_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblUnit_s'> </a></td>	
					<td align="center" style="width:100px;"><a id='lblMount_s'> </a></td>	
					<td align="center" style="width:100px;"><a id='lblWeight_s'> </a></td>	
					<td align="center" style="width:100px;"><a id='lblRate_s'> </a></td>	
					<td align="center" style="width:100px;"><a id='lblApv_s'> </a></td>	
					<td align="center" style="width:100px;"><a id='lblTranmoney_s'> </a></td>	
					<td align="center" style="width:100px;"><a id='lblPrice_s'> </a></td>	
					<td align="center" style="width:100px;"><a id='lblHprice_s'> </a></td>	
					<td align="center" style="width:100px;"><a id='lblPprice_s'> </a></td>	
					<td align="center" style="width:100px;"><a id='lblLprice_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblWcost_s'> </a></td>	
					<td align="center" style="width:100px;"><a id='lblSprice_s'> </a></td>	
					<td align="center" style="width:100px;"><a id='lblSprice2_s'> </a></td>	
					<td align="center" style="width:100px;"><a id='lblTranmoney2_s'> </a></td>	
					<td align="center" style="width:100px;"><a id='lblTrantype_s'> </a></td>	
					<td align="center" style="width:100px;"><a id='lblTranaddr_s'> </a></td>	
					<td align="center" style="width:100px;"><a id='lblTranmoney3_s'> </a></td>	
					<td align="center" style="width:100px;"><a id='lblVccno_s'> </a></td>	
					<td align="center" style="width:100px;"><a id='lblWorker_s'> </a></td>	
					<td align="center" style="width:100px;"><a id='lblProfit_s'> </a></td>	
					<td align="center" style="width:100px;"><a id='lblTotal_s'> </a></td>	
					<td align="center" style="width:200px;"><a id='lblProduct_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblInte_s'> </a></td>	
					<td align="center" style="width:100px;"><a id='lblDaya_s'> </a></td>		
                </tr>
                
                <tr style='background:#cad3ff;'>
                    <td align="center">
	                    <input class="btn" id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
	                    <input id="txtNoq.*" type="text" style="display: none;"/>
                    </td>
                    <td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
                    <td><input type="text" id="txtDatea.*" style="width:95%;"/></td>
                    <td>
                    	<input type="text" id="txtCustno.*" style="width:95%;"/>
                    	<input type="text" id="txtCust.*" style="display:none;"/>
                    	<input type="text" id="txtNick.*" style="display:none;"/>
                    	
                    	<input type="text" id="txtCash.*" style="display:none;"/>
                    	<input type="text" id="txtTypea.*" style="display:none;"/>
                    </td>
                    <td><input type="text" id="txtLengthb.*" style="width:95%;"/></td>
                    <td><input type="text" id="txtUnit.*" style="width:95%;"/></td>
                    <td><input type="text" id="txtMount.*" style="width:95%;"/></td>
                    <td><input type="text" id="txtWeight.*" style="width:95%;"/></td>
                    <td><input type="text" id="txtRate.*" style="width:95%;"/></td>
                    <td><input type="text" id="txtApv.*" style="width:95%;"/></td>
                    <td><input type="text" id="txtTranmoney.*" style="width:95%;"/></td>
                    <td><input type="text" id="txtPrice.*" style="width:95%;text-align: right;"/></td>
					<td><input type="text" id="txtHprice.*" style="width:95%;text-align: right;"/></td>
					<td><input type="text" id="txtPprice.*" style="width:95%;text-align: right;"/></td>
					<td><input type="text" id="txtLprice.*" style="width:95%;text-align: right;"/></td>
					<td><input type="text" id="txtWcost.*" style="width:95%;text-align: right;"/></td>
					<td><input type="text" id="txtSprice.*" style="width:95%;text-align: right;"/></td>
					<td><input type="text" id="txtSprice2.*" style="width:95%;text-align: right;"/></td>
					<td><input type="text" id="txtTranmoney2.*" style="width:95%;text-align: right;"/></td>
					<td><input type="text" id="txtTrantype.*" style="width:95%;"/></td>
					<td><input type="text" id="txtTranaddr.*" style="width:95%;"/></td>
					<td><input type="text" id="txtTranmoney3.*" style="width:95%;text-align: right;"/></td>
					<td>
						<input type="text" id="txtVccno.*" style="width:95%;"/>
						<input type="text" id="txtAccy.*" style="display:none;"/>
						<input type="text" id="txtTablea.*" style="display:none;"/>
						<input type="text" id="txtVccnoq.*" style="display:none;"/>
					</td>
					<td><input type="text" id="txtWorker.*" style="width:95%;"/></td>
					<td><input type="text" id="txtProfit.*" style="width:95%;"/></td>
					<td><input type="text" id="txtTotal.*" style="width:95%;"/></td>
					
					<td>
						<input type="text" id="txtProductno.*" style="width:95%;"/>
						<input type="text" id="txtProduct.*" style="width:95%;"/>
						<input id="btnProduct.*" type="button" style="display:none;">
					</td>
					<td><input type="text" id="txtInte.*" style="width:95%;"/></td>
					<td><input type="text" id="txtDaya.*" style="width:95%;"/></td>
                </tr>
            </table>
        </div>
        <input id="q_sys" type="hidden" />
    </body>
</html>
