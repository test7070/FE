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
		<script type="text/javascript">
            this.errorHandler = null;
            function onPageError(error) {
                alert("An error occurred:\r\n" + error.Message);
            }

            q_desc = 1;
            q_tables = 's';
            var q_name = "inchg";
            var q_readonly = [];
            var q_readonlys = [];
            var bbmNum = [];
            var bbsNum = [];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'Datea';
            aPop = new Array(['txtTggno', 'lblTgg', 'sss', 'noa,namea', 'txtTggno,txtTgg', 'sss_b.aspx'],
            				 ['txtCustno', 'lblCust', 'cust', 'noa,comp', 'txtCustno,txtCust', 'cust_b.aspx']
            );

            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1)
            });

            //////////////////   end Ready
            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(1);
            }

            function mainPost() {
                q_getFormat();
                bbmMask = [['txtDatea', r_picd], ['txtBdate', r_picm]];
                bbsNum = [['txtDocn', 15, 0, 1], ['txtArrange', 15, 0, 1], ['txtCommission', 15, 0, 1]];
                q_mask(bbmMask); 
                
                document.title='業務費用登錄';
                $('#vewTgg').text('業務');
                $('#lblBdate').text('月份');
                $('#lblTgg').text('業務');
                       
            }

            function q_boxClose(s2) {///   q_boxClose 2/4
                var
                ret;
                switch (b_pop) {
                    case q_name + '_s':
                        q_boxClose2(s2);
                        ///   q_boxClose 3/4
                        break;
                }/// end Switch
                b_pop = '';
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }  /// end switch
            }

            function btnOk() {
                t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);
                if (t_err.length > 0) {
                    alert(t_err);
                    return;
                }

                $('#txtWorker').val(r_name);

                var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
                if (s1.length == 0 || s1 == "AUTO")
                    q_gtnoa(q_name, replaceAll('IC' + $('#txtDatea').val(), '/', ''));
                else
                    wrServer(s1);
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;

                q_box('inchg_s.aspx', q_name + '_s', "500px", "330px", q_getMsg("popSeek"));
            }

            function combPay_chg() {
            }

            function bbsAssign() {
            	$('#lblDocn').text('其他費用');
                $('#lblArrange').text('交際費');  
            	for (var i = 0; i < q_bbsCount; i++) {
                    $('#lblNo_' + i).text(i + 1);
                }
                _bbsAssign();
            }

            function btnIns() {
                _btnIns();
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
                $('#txtDatea').val(q_date());
                $('#txtBdate').val(q_date().substr(0,6))
                $('#txtDatea').focus();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
            }

            function btnPrint() {
				q_box('z_inchgs_fe.aspx' + "?;;;noa='" + trim($('#txtNoa').val()), '', "95%", "95%", q_getMsg("popPrint"));
            }

            function wrServer(key_value) {
                var i;

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {                
				if (!as['docn'] && !as['commission'] && !as['arrange']) {
					as[bbsKey[1]] = '';
					return;
				}
				
                q_nowf();
                as['datea'] = abbm2['datea'];

                return true;
            }
			
            function refresh(recno) {
            	document.title='業務費用登錄';
                $('#vewTgg').text('業務');
                $('#lblBdate').text('月份');
                $('#lblTgg').text('業務');
               
                _refresh(recno);
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
            }

            function btnMinus(id) {
                _btnMinus(id);
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
                width: 98%;
            }
            .tview {
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
                width: 75%;
                margin: 1px;
                /*border: 1px black solid;*/
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
                height: 37px;
            }
            .tbbm tr td {
                width: 9%;
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
                width: 98%;
                float: left;
            }
            .txt.c2 {
                width: 35%;
                float: left;
            }
            .txt.c3 {
                width: 60%;
                float: left;
            }
            .txt.c4 {
                width: 18%;
                float: left;
            }
            .txt.c5 {
                width: 80%;
                float: left;
            }
            .txt.c6 {
                width: 50%;
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
                font-size: medium;
            }
            .tbbm textarea {
                font-size: medium;
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
                color: black;
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
		<div id='dmain' >
			<div class="dview" id="dview" style="float: left; width:25%;">
				<table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>
						<td align="center" style="width:20%"><a id='vewDatea'> </a></td>
						<td align="center" style="width:20%"><a id='vewNoa'> </a></td>
						<td align="center" style="width:20%"><a id='vewTgg'> </a></td>
					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox" style=' '/></td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='noa'>~noa</td>
						<td align="center" id='tgg'>~tgg</td>
					</tr>
				</table>
			</div>
			<div class='dbbm' style="width: 480px;float:left">
				<table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
					<tr style="height:1px;">
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td class='td3' ><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td class='td4' ><input id="txtNoa" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td class='td1' ><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td class='td2' ><input id="txtDatea" type="text" class="txt c1"/></td>
						<td class='td1' ><span> </span><a id="lblBdate" class="lbl"> </a></td>
						<td class='td2' ><input id="txtBdate" type="text" class="txt c1"/></td>

					</tr>
					<tr>
						<td class='td1'><span> </span><a id="lblCust" class="lbl btn"> </a></td>
						<td class="td2" colspan="3">
							<input id="txtCustno"  type="text" class="txt c2" style="width: 30%"/>
							<input id="txtComp"  type="text"  class="txt c3" style="width: 70%"/>
						</td>
					</tr>
					<tr>
						<td class='td1'><span> </span><a id="lblTgg" class="lbl btn"> </a></td>
						<td class="td2" colspan="3">
							<input id="txtTggno"  type="text" class="txt c2" style="width: 30%"/>
							<input id="txtTgg"  type="text"  class="txt c3" style="width: 70%"/>
						</td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td class="td2" colspan="3">
							<input id="txtMemo"  type="text"  class="txt c3" style="width: 100%"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs' style="width: 800px;">
			<table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
				<tr style='color:White; background:#003366;' >
					<td align="center"><input class="btn" id="btnPlus" type="button" value='＋' style="font-weight: bold;" /></td>
					<td align="center" style="width: 2%"><a id='lblNo'> </a></td>
					<td align="center" ><a id='lblDocn'> </a></td>
					<td align="center" ><a id='lblCommission'> </a></td>
					<td align="center" ><a id='lblArrange'> </a></td>
					</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center"><input class="btn" id="btnMinus.*" type="button" value='－' style=" font-weight: bold;" /></td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td >
						<input class="txt num c1" id="txtDocn.*" type="text" />
						<input id="txtNoq.*" type="hidden" />
					</td>					
					<td ><input class="txt num c1" id="txtCommission.*" type="text" /></td>
					<td ><input class="txt num c1" id="txtArrange.*" type="text" /></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
