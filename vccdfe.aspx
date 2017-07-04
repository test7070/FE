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
            
            var q_name = "vccd";
            var q_readonly = ['txtWorker','txtWorker2','txtApv'];
            var bbmNum = [['txtMatcha', 10, 0, 1],['txtEarcha', 10, 0, 1],['txtTotal', 10, 0, 1],['txtCarriage', 10, 0, 1]];
            var bbmMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwCount2 = 8;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'Datea';
            q_desc = 1;
			var aPop = new Array(
				['txtCno', 'lblCno', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx'],
				['txtMechno', 'lblMech', 'mech', 'noa,mech', 'txtMechno,txtMech', 'mech_b.aspx'],
				['txtCustno', 'lblCust', 'cust', 'noa,comp', 'txtCustno,txtComp', 'cust_b.aspx'],
				['txtSalesno', 'lblSalesno', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx']
			);
            $(document).ready(function() {
                bbmKey = ['noa'];
                q_brwCount();
                
                
                if (r_rank <8){
                	q_gt('acomp', 'where=^^1=1^^', 0, 1);
				}else{
					q_gt(q_name, q_content, q_sqlCount, 1,0,'',r_accy);
				}
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
                bbmMask = [['txtDatea', r_picd],['txtVdate', r_picd],['txtUdate', r_picd]];
                q_mask(bbmMask);
                
                $('#btnVccs').click(function() {
                	var t_noa = $('#txtNoa').val();
					var t_where = '';
					if (t_noa.length > 0){
						t_where = "noa='" + t_noa + "'";
						q_box("vccsfe_seek_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'vccsfe', "95%", "95%", q_getMsg('btnVccs'));
					}
				});
				
				$('#btnApv').click(function() {
                	var t_noa = $('#txtNoa').val();
					if (t_noa.length > 0){
						q_func('qtxt.query.vccd', 'vccd.txt,changeapv,' + encodeURI(t_noa)); 	
					}
				});
				
				$('#txtNoa').change(function(e){
                	$(this).val($.trim($(this).val()).toUpperCase());    	
					if($(this).val().length>0){
						t_where="where=^^ noa='"+$(this).val()+"'^^";
                   		q_gt('vccd', t_where, 0, 0, 0, "checkVccdno_change", r_accy);
					}
                });
            }
            
            function q_funcPost(t_func, result) {
                switch(t_func) {
                    case 'qtxt.query.vccd':
                        var as = _q_appendData("tmp0", "", true, true);
                        if (as[0] != undefined) {
                           $('#txtApv').val(as[0].apv);
                           $('#vtapv_'+q_recno).text(as[0].apv);
                           abbm[q_recno]['apv']=as[0].apv;
                           q_func('vccd_post.post', r_accy+','+$('#txtNoa').val()+',1'); 	
                        }
                        break;
                }
            }

            function q_boxClose(s2) {///   q_boxClose 2/4
                var ret;
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
                	case 'acomp':
						var as = _q_appendData("acomp", "", true);
						if (q_getPara('sys.project').toUpperCase()=='FE' && (r_userno.substr(0,1).toUpperCase())=='B'){
							q_content = "where=^^salesno='" + r_userno + "'^^";
							q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
		
						}else{
							q_content = "";
							q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
						}
						break;
                	case 'checkVccdno_change':
                		var as = _q_appendData("vccd", "", true);
                        if (as[0] != undefined){
                        	alert('退貨單已存在 '+as[0].noa);
                        }else{
                        	t_where="where=^^ noa='"+$('#txtNoa').val()+"'^^";
                   			q_gt('vcc', t_where, 0, 0, 0, "input_vcc", r_accy);
                        }
                		break;
                	case 'input_vcc':
                		var as1 = _q_appendData("vcc", "", true);
                		var as2 = _q_appendData("vccs", "", true);
                		if (as1[0] != undefined){
                			$('#txtVdate').val(as1[0].datea);
                			$('#txtCustno').val(as1[0].custno);
                			$('#txtComp').val(as1[0].comp);
                			$('#txtSalesno').val(as1[0].salesno);
                			$('#txtSales').val(as1[0].sales);
                			$('#txtDriverno').val(as1[0].driverno);
                			$('#txtDriver').val(as1[0].driver);
                			$('#txtCarno').val(as1[0].carno);
                			$('#txtCno').val(as1[0].cno);
                			$('#txtAcomp').val(as1[0].acomp);
                		}
                		if (as2[0] != undefined){
                			$('#txtProduct').val(as2[0].product);
                			$('#txtBkaddr').val(as2[0].storeno);
                		}
                		break;
                	case 'checkVccdno_btnOk':
                		var as = _q_appendData("vccd", "", true);
                        if (as[0] != undefined){
                        	alert('退貨單已存在 '+as[0].noa);
                            Unlock();
                            return;
                        }else{
                        	wrServer($('#txtNoa').val());
                        }
                		break;
					case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }  /// end switch
            }
            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
            }

			function btnOk() {
            	Lock(); 
				$('#txtNoa').val($.trim($('#txtNoa').val()));
				if(q_cur==1){
                	t_where="where=^^ noa='"+$('#txtNoa').val()+"'^^";
                    q_gt('vccd', t_where, 0, 0, 0, "checkVccdno_btnOk", r_accy);
                }else{
                	Unlock();
                	wrServer($('#txtNoa').val());
                }
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)
					return;
				q_box('vccdfe_s.aspx', q_name + '_s', "500px", "420px", q_getMsg("popSeek"));
            }


            function btnIns() {
                _btnIns();
                $('#txtDatea').val(q_date());
                $('#txtDatea').focus();
                refreshBbm();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                $('#txtDatea').focus();
                //sum();
                refreshBbm();
            }

            function btnPrint() {
				t_where = "noa='" + $('#txtNoa').val() + "'";
				q_box("z_vccdfep.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, '', "95%", "95%", q_getMsg('popPrint'));
            }

            function wrServer(key_value) {
                var i;

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], '', '', 2);
            }

            function refresh(recno) {
                _refresh(recno);
                refreshBbm();
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                if(t_para){
                	$('#btnApv').removeAttr('disabled');
                }else{
                	$('#btnApv').attr('disabled','disabled');
                	
                }
            }

            function btnMinus(id) {
                _btnMinus(id);
                //sum();
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
            
            function refreshBbm(){
            	if(q_cur==1){
            		$('#txtNoa').css('color','black').css('background','white').removeAttr('readonly');
            	}else{
            		$('#txtNoa').css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
            	}
            }
		</script>
		<style type="text/css">
            #dmain {
                /*overflow: hidden;*/
            }
            .dview {
                float: left;
                width: 1260px;
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
                width: 1000px;
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
            td .schema {
                display: block;
                width: 95%;
                height: 0px;
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
                font-size: medium;
            }
            .num {
                text-align: right;
            }
            input[type="text"], input[type="button"], select {
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
		<div id='dmain' >
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewNoa_fe'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewDatea'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewVdate'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewCustno'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewComp'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewSalesno'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewSales'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewDriver'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewCarno'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewApv'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" /></td>
						<td id="noa" style="text-align: center;">~noa</td>
						<td id="datea" style="text-align: center;">~datea</td>
						<td id="vdate" style="text-align: center;">~vdate</td>
						<td id="custno" style="text-align: center;">~custno</td>
						<td id="comp,4" style="text-align: center;">~comp,4</td>
						<td id="salesno" style="text-align: center;">~salesno</td>
						<td id="sales" style="text-align: center;">~sales</td>
						<td id="driver" style="text-align: center;">~driver</td>
						<td id="carno" style="text-align: center;">~carno</td>
						<td id="apv" style="text-align: center;">~apv</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
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
						<td><span> </span><a id='lblNoa_fe' class="lbl"> </a></td>
						<td><input id="txtNoa"  type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td><input id="txtDatea"  type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblMatcha' class="lbl"> </a></td>
						<td><input id="txtMatcha"  type="text" class="txt num c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblSourceaddr' class="lbl"> </a></td>
						<td><input id="txtSourceaddr"  type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblBkaddr_fe' class="lbl"> </a></td>
						<td><input id="txtBkaddr"  type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblEarcha' class="lbl"> </a></td>
						<td><input id="txtEarcha"  type="text" class="txt num c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblProduct' class="lbl"> </a></td>
						<td colspan="3"><input id="txtProduct"  type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblTotal' class="lbl"> </a></td>
						<td><input id="txtTotal"  type="text" class="txt num c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo"  class="lbl"> </a></td>
						<td colspan="3"><input id="txtMemo"  type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblCarriage' class="lbl"> </a></td>
						<td><input id="txtCarriage"  type="text" class="txt num c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblLead' class="lbl"> </a></td>
						<td>
							<input id="txtLead"  type="text" class="txt c1" style="width: 49%;"/>
							<select id="cmbLeadtype" class="txt c1" style="width: 49%;"> </select>
						</td>
						<td><span> </span><a id='lblStooge' class="lbl"> </a></td>
						<td>
							<input id="txtStooge"  type="text" class="txt c1" style="width: 49%;"/>
							<select id="cmbStoogetype" class="txt c1" style="width: 49%;"> </select>
						</td>
						<td><span> </span><a id="lblApv"  class="lbl"> </a></td>
						<td>
							<input id="txtApv"  type="text" class="txt c1" style="width: 20%;"/>
							<input id="btnVccs" type="button" style="width: 35%;height: 21px;font-size: 15px;"/>
							<input id="btnApv" type="button" style="width: 35%;height: 21px;font-size: 15px;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo2"  class="lbl"> </a></td>
						<td colspan="5">
							<textarea id="txtMemo2"  type="text" class="txt c1" rows="3"> </textarea>
							<!--已下為相關資料但不顯示-->
							<input id="txtCno" type="hidden" class="txt" style="width: 30%"/>
							<input id="txtAcomp"  type="hidden"  class="txt" style="width: 70%"/>
							<input id="txtCustno" type="hidden" style="float:left; width:30%;"/>
							<input id="txtComp" type="hidden" style="float:left; width:70%;"/>
							<input id="txtSalesno"  type="hidden" style="width:30%; float:left;"/>
							<input id="txtSales"  type="hidden" style="width:70%; float:left;"/>
							<input id="txtVdate"  type="hidden" class="txt c1"/>
							<input id="txtDriverno"  type="hidden" style="width:30%; float:left;"/>
							<input id="txtDriver"  type="hidden" style="width:70%; float:left;"/>
							<input id="txtCarno"  type="hidden" class="txt c1"/>
							<input id="txtWorker"  type="hidden" class="txt c1"/>
							<input id="txtWorker2"  type="hidden" class="txt c1"/>
							
						</td>
					</tr>
				</table>
			</div>
		</div>	
		<input id="q_sys" type="hidden" />
	</body>
</html>
