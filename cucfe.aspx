<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title> </title>
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
			q_desc=1;
            q_tables = 's';
            var q_name = "cuc";
            var q_readonly = ['txtNoa','txtWorker', 'txtWorker2','txtMech'];
            var q_readonlys = ['txtCust','txtProductno', 'txtProduct','txtScolor','txtLengthb','txtMount','txtWeight', 'txtOrdeno', 'txtNo2'];
            var bbmNum = [];
            var bbsNum = [];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'Noa';
            brwCount2 = 6;
            aPop = new Array(
            	['txtMechno', 'lblMech', 'mech', 'noa,mech', 'txtMechno,txtMech', 'mech_b.aspx']
            );

            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
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
            	document.title='鋼筋彎曲單';
            	bbsNum = [['txtMount', 15, 0, 1], ['txtWeight', 15, 2, 1], ['txtLengthb', 10, 0, 1]];
                q_getFormat();
                bbmMask = [['txtDatea', r_picd],['txtBdate', r_picd]];
                bbsMask = [];
                q_mask(bbmMask);
                
                
                $('#btnWorkjImport').click(function() {
					var t_mech=$('#txtMechno').val();
					var t_where = " 1=1";
					//裁剪已完工
					t_where = t_where + " and exists (select * from view_cubs where ordeno=a.noa and no2=b.noq and ISNULL(enda,0)=1 and isnull(processno,'')='"+t_mech+"' )";
					//折數>1
					t_where = t_where + " and exists (select * from img where noa=b.picno and isnull(fold,0)>0)";
					if(q_cur==1 || q_cur==2)
						q_box("workjsfe_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'workjsfe_b', "95%", "95%", q_getMsg('popOrde'));
				});
            }

            function q_popPost(s1) {
                switch(s1) {
                }
            }

            function q_boxClose(s2) {///   q_boxClose 2/4
                var ret;
                switch (b_pop) {
                	case 'workjsfe_b':
                		if (q_cur > 0 && q_cur < 4) {
							if (!b_ret || b_ret.length == 0) {
								b_pop = '';
								return;
							}
							
	                		ret = q_gridAddRow(bbsHtm, 'tbbs', 'txtCustno,txtCust,txtProductno,txtProduct,txtScolor,txtOrdeno,txtNo2,txtLengthb,txtWeight,txtMount,txtMemo,txtImgdata,txtPicno'
									, b_ret.length, b_ret, 'custno,cust,productno,product,place,noa,noq,lengthb,weight,mount,memo,imgdata,picno', 'txtProductno');
	                		refreshimg();
                		}
                		break;
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
                }
            }
            

            function btnOk() {
                var t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')], ['txtDatea', q_getMsg('lblDatea')]]);
                if (t_err.length > 0) {
                    alert(t_err);
                    return;
                }
				
				$('#txtNoa').val(trim($('#txtNoa').val()));
				var t_noa = trim($('#txtNoa').val());
				
                if (q_cur == 1){
                    $('#txtWorker').val(r_name);
                }else{
                    $('#txtWorker2').val(r_name);
				}
				
				for(var i=0;i<q_bbsCount;i++){
                	createImg(i);
                }
				
                var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
                var t_date = trim($('#txtDatea').val());
                if (s1.length == 0 || s1 == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_cuc') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(s1);
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
                q_box('cucfe_s.aspx', q_name + '_s', "500px", "310px", q_getMsg("popSeek"));
            }

            function combPay_chg() {
            }

            function bbsAssign() {
                for (var j = 0; j < q_bbsCount; j++) {
                	$('#lblNo_' + j).text(j + 1);
                    if (!$('#btnMinus_' + j).hasClass('isAssign')) {

                    }
                }
                _bbsAssign();
                $('#lblDatea').text('日期');
                $('#lblMech').text('機台');
                $('#btnWorkjImport').val('加工單匯入');
                $('#lblProductno_s').text('品號');
                $('#lblProduct_s').text('品名');
                $('#lblScolor_s').text('位置');
                $('#lblPic_s').text('型狀');
                $('#lblLengthb_s').text('訂單長度');
                $('#lblMount_s').text('訂單數量');
                $('#lblWeight_s').text('訂單重量');
                $('#lblMemo_s').text('備註');
                $('#lblWaste_s').text('完工');
                $('#lblOrdeno_s').text('加工單號');
                $('#lblNo2_s').text('序號');
                refreshimg();
            }
            
            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtDatea').val(q_date()).focus();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
            }

            function btnPrint() {
				q_box('z_cucfep.aspx' + "?;;;noa=" + trim($('#txtNoa').val()) + ";" + r_accy, '', "95%", "95%", q_getMsg("popPrint"));
            }

            function wrServer(key_value) {
                var i;

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (!as['productno'] && !as['product']) {
                    as[bbsKey[1]] = '';
                    return;
                }

                q_nowf();

                return true;
            }

            ///////////////////////////////////////////////////  以下提供事件程式，有需要時修改
            function refresh(recno) {
                _refresh(recno);
            }
            function refreshimg(){
                for (var j = 0; j < q_bbsCount; j++) {
					if(!emp($('#txtImgdata_'+j).val())){
						$('#imgPic_'+j).attr('src',$('#txtImgdata_'+j).val()).show();
					}else{
						$('#imgPic_'+j).hide();
					}
				}
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
                border-width: 0px;
                width: 30%;
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
                width: 9%;
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
                font-size: medium;
            }
            .tbbm tr td .lbl.btn:hover {
                color: #FF8F19;
            }
            .txt.c1 {
                width: 98%;
                float: left;
            }

            .num {
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
            input[type="text"], input[type="button"] ,select{
                font-size: medium;
            }
            .dbbs {
                width: 1460px;
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
                width: 100%;
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
            #q_acDiv {
                white-space: nowrap;
            }
		</style>
	</head>
	<body>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' >
			<div class="dview" id="dview" >
				<table class="tview" id="tview" >
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>
						<td align="center" style="width:20%"><a id='vewNoa'> </a></td>
						<td align="center" style="width:25%"><a id='vewDatea'> </a></td>
						<td align="center" style="width:25%"><a id='vewMech'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=' '/></td>
						<td align="center" id='noa'>~noa</td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='mech'>~mech</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm" id="tbbm">
					<tr>
						<td><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td><input id="txtNoa"  type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td><input id="txtDatea"  type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMech" class="lbl btn"> </a></td>
						<td>
							<input id="txtMechno"  type="text" class="txt c1" style="width: 30%;"/>
							<input id="txtMech"  type="text" class="txt c1"  style="width: 65%;"/>
						</td>
						<td><input type="button" id="btnWorkjImport" style="width:120px;"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td><input id="txtWorker" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblWorker2" class="lbl"> </a></td>
						<td><input id="txtWorker2" type="text" class="txt c1"/></td>
					</tr>
				</table>
			</div>
			<div class='dbbs' >
				<table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
					<tr style='color:White; background:#003366;'>
						<td align="center" style="width: 1%;"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /></td>
						<td style="width:20px;"> </td>
						<td style="width:150px;"><a id='lblCustno_s'> </a></td>
						<td style="width:120px;"><a id='lblProductno_s'> </a></td>
						<td style="width:200px;"><a id='lblProduct_s'> </a></td>
						<td style="width:100px;"><a id='lblScolor_s'> </a></td>
						<td style="width:200px;" class="pic"><a id='lblPic_s'> </a></td>
						<td style="width:80px;"><a id='lblLengthb_s'> </a></td>
						<td style="width:80px;"><a id='lblMount_s'> </a></td>
						<td style="width:100px;"><a id='lblWeight_s'> </a></td>
						<td><a id='lblMemo_s'> </a></td>
						<td style="width:30px;"><a id='lblWaste_s'> </a></td>
						<td style="width:120px;"><a id='lblOrdeno_s'> </a></td>
						<td style="width:50px;"><a id='lblNo2_s'> </a></td>
					</tr>
					<tr  style='background:#cad3ff;'>
						<td align="center"><input class="btn" id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" /></td>
						<td>
							<a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a>
							<input id="txtNoq.*" type="hidden"/>
						</td>
						<td>
							<input id="txtCustno.*" type="text" class="txt c1" style="display:none;"/>
							<input id="txtCust.*" type="text" class="txt c1"/>
						</td>
						<td><input id="txtProductno.*" type="text" class="txt c1"/></td>
						<td><input id="txtProduct.*" type="text" class="txt c1"/></td>
						<td><input id="txtScolor.*" type="text" class="txt c1"/></td>
						<td>
							<img id="imgPic.*" src="" style="display:none;"/>
							<textarea id="txtImgdata.*" style="display:none;"> </textarea>
							<input class="txt" id="txtPicno.*" type="text" style="width:95%;display:none;"/>
						</td>
						<td><input id="txtLengthb.*" type="text" class="txt c1 num"/></td>
						<td><input id="txtMount.*" type="text" class="txt c1 num"/></td>
						<td><input id="txtWeight.*" type="text" class="txt c1 num"/></td>
						<td><input id="txtMemo.*" type="text" class="txt c1"/></td>
						<td>
							<input id="checkWaste.*" type="checkbox"/>
							<input id="txtWaste.*" type="hidden"/>
						</td>
						<td><input id="txtOrdeno.*" type="text" class="txt c1"/></td>
						<td><input id="txtNo2.*" type="text" class="txt c1"/></td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
