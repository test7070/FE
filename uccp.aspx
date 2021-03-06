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
        <link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
        <script src="css/jquery/ui/jquery.ui.core.js"></script>
        <script src="css/jquery/ui/jquery.ui.widget.js"></script>
        <script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
        <script type="text/javascript">
            q_tables = 's';
            var q_name = "uccp";
            var q_readonly = ['txtWorker2', 'txtWorker','txtNoa'];
            var q_readonlys = [];
            var bbmNum = [['txtPrice_import',10,3,1]];
            var bbsNum = [['txtSprice',10,3,1],['txtLprice',10,3,1]];
            var bbmMask = [['txtDatea', '999/99/99'],['txtEdate', '999/99/99'],['txtBdate', '999/99/99'],['txtDatea_import','999/99/99']];
            var bbsMask = [['txtLdate', '999/99/99']];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'datea';
            q_desc = 1;
            brwCount2 = 5;
            q_bbsLen = 5;

            aPop = new Array(['txtProductno_', 'btnProductno_', 'ucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucc_b.aspx']
            	,['txtBproductno', 'btnBproductno', 'ucc', 'noa,product', 'txtBproductno', 'ucc_b.aspx']
            	,['txtEproductno', 'btnEproductno', 'ucc', 'noa,product', 'txtEproductno', 'ucc_b.aspx']);
            t_groupano = "";
            t_groupbno = "";
            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1);
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
                q_mask(bbmMask);
               	q_gt('uccga', '', 0, 0, 0, "");
                
                $('.'+q_getPara('sys.project')).show();
               	if(t_groupbno.length>0)
                	q_cmbParse("cmbGroupbno_import", t_groupbno);
            	$('#txtDatea_import').datepicker();
                	
                $('#txtBproductno').bind('contextmenu', function(e) {
					/*滑鼠右鍵*/
					e.preventDefault();
					if(!(q_cur==1 || q_cur==2))
						return;
					$('#btnBproductno').click();
				});
				$('#txtEproductno').bind('contextmenu', function(e) {
					/*滑鼠右鍵*/
					e.preventDefault();
					if(!(q_cur==1 || q_cur==2))
						return;
					$('#btnEproductno').click();
				});
				$('#btnImport').click(function(e){
                	var t_date = $.trim($('#txtDatea').val());
                	var t_bdate = $.trim($('#txtBdate').val());
                	var t_edate = $.trim($('#txtEdate').val());
                	var t_bproductno = $.trim($('#txtBproductno').val());
                	var t_eproductno = $.trim($('#txtEproductno').val());
                	
                	if(t_date.length==0){
                		alert('請輸入基價日期。');
                		return;
                	}
                	if(t_bdate.length==0 || t_edate.length==0){
                		alert('請輸入庫存運算截止日。');
                		return;
                	}
                	Lock(1, {
	                    opacity : 0
	                });
                	q_func('qtxt.query.uccp', 'uccp.txt,import,' + encodeURI(t_date) + ';' + encodeURI(t_bdate) + ';' + encodeURI(t_edate)+ ';' + encodeURI(t_bproductno)+ ';' + encodeURI(t_eproductno)); 	
                });
						
                $('#btnImport_import').click(function(e){
                	var t_date = $.trim($('#txtDatea_import').val());
                	var t_groupbno = $.trim($('#cmbGroupbno_import').val());
                	var t_price = $.trim($('#txtPrice_import').val()).replace(',','');
                	
                	if(t_date.length==0){
                		alert('請輸入基價日期。');
                		return;
                	}
                	if(t_groupbno.length==0){
                		alert('請選擇中類。');
                		return;
                	}
                	try{
                		t_price = parseFloat(t_price);
                	}catch(e){
                		alert('單價錯誤。');
                		return;
                	}
                	Lock(1, {
	                    opacity : 0
	                });
                	q_func('qtxt.query.uccp_groupb', 'uccp.txt,groupb,' + encodeURI(t_date) + ';' + encodeURI(t_groupbno) + ';' + encodeURI(t_price)); 	
                });
                
				$('#btnCancel_import').click(function(e){
                	$('#divImport').hide();
                });
                
                $('#divImport').mousedown(function(e) {
                    if (e.button == 2) {
                        $(this).data('xtop', parseInt($(this).css('top')) - e.clientY);
                        $(this).data('xleft', parseInt($(this).css('left')) - e.clientX);
                    }
                }).mousemove(function(e) {
                    if (e.button == 2 && e.target.nodeName != 'INPUT') {
                        $(this).css('top', $(this).data('xtop') + e.clientY);
                        $(this).css('left', $(this).data('xleft') + e.clientX);
                    }
                }).bind('contextmenu', function(e) {
                    if (e.target.nodeName != 'INPUT')
                        e.preventDefault();
                });

                $('#btnImport2').click(function() {
                    $('#divImport').toggle();
                    $('#txtDatea_import').focus();
                });
                $('#cmbGroupano_import').change(function(){
					var thisVal = $(this).val();
					var t_where = "where=^^ left(noa,1)=N'" + thisVal + "' ^^";
					if (thisVal==' '){
						q_gt('uccgb', '', 0, 0, 0, "");
					}else{
						q_gt('uccgb', t_where, 0, 0, 0, "uccgb");
					}
					
				});
                
            }
            function q_funcPost(t_func, result) {
                switch(t_func) {
                	case 'qtxt.query.uccp_groupb':
                		var as = _q_appendData("tmp0", "", true, true);
                        if (as[0] != undefined) {
                        } else {
                        }
                        location.reload();
                        Unlock(1);
                        break;
                    case 'qtxt.query.uccp':
                        var as = _q_appendData("tmp0", "", true, true);
                        if (as[0] != undefined) {
                            q_gridAddRow(bbsHtm, 'tbbs', 'txtProductno,txtProduct,txtLprice,txtLdate'
                        	, as.length, as, 'productno,product,lprice,ldate', '','');
                        } else {
                            alert('無資料!');

                        }
                        Unlock(1);
                        break;
                    default:
                    	break;
                }
            }
            var uccgbList=[];
            var thisuccgbList='';
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
						q_cmbParse("cmbGroupano_import", t_groupano);
						break;
                	case 'uccgb':
						var as = _q_appendData("uccgb", "", true);
						var t_gnoa=$("#cmbGroupano_import").val();
						//carnoList = as;
						t_groupbno = " @ ";
						if (as[0] != undefined) {
							for ( i = 0; i < as.length; i++) {
									t_groupbno = t_groupbno + (t_groupbno.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].noa+' . '+as[i].namea;
							}
						}
						/*for(var k=0;k<uccgbList.length;k++){
							if(uccgbList[k].noa.substr(0,1)==t_gnoa){
								thisuccgbList = uccgbList[k].noa;
								break;
							}
						}*/
						document.all.cmbGroupbno_import.options.length = 0;
						q_cmbParse("cmbGroupbno_import", t_groupbno);
						break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }
            }
            function q_boxClose(s2) {
				var ret;
				switch (b_pop) {
					case q_name + '_s':
						q_boxClose2(s2);
						break;
					default:
						break;
				}
				b_pop = '';
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
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_uccp') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
            }
            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)
                    return;
                q_box('uccp_s.aspx', q_name + '_s', "600px", "530px", q_getMsg("popSeek"));
            }
            function bbsAssign() {
                for (var j = 0; j < q_bbsCount; j++) {
                    $('#lblNo_' + j).text(j + 1);
                    if (!$('#btnMinus_' + j).hasClass('isAssign')) {
                        $('#txtProductno_' + j).bind('contextmenu', function(e) {
							/*滑鼠右鍵*/
							e.preventDefault();
							if(!(q_cur==1 || q_cur==2))
								return;
							var n = $(this).attr('id').replace('txtProductno_', '');
							$('#btnProductno_'+n).click();
						});
                        $('#txtPrice_'+j).change(function(e){
                            sum();
                        });
                    }
                }
                _bbsAssign();
                $('.'+q_getPara('sys.project')).show();
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
                q_box("z_uccpp.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + JSON.stringify({noa:trim($('#txtNoa').val())}) + ";" + r_accy + "_" + r_cno, 'uccp', "95%", "95%", m_print);
            }
            function wrServer(key_value) {
                var i;
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }
            function bbsSave(as) {
                if (!as['productno'] || as['sprice']==0) {
                    as[bbsKey[1]] = '';
                    return;
                }
                q_nowf();
                as['datea'] = abbm2['datea'];
                return true;
            }
            function sum() {
                if (!(q_cur == 1 || q_cur == 2))
                    return;
            }
            function refresh(recno) {
                _refresh(recno);
                $('.'+q_getPara('sys.project')).show();
            }
            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                if (t_para) {
                	$('#txtDatea').datepicker('destroy');
                    $('#txtBdate').datepicker('destroy');
                    $('#txtEdate').datepicker('destroy');
                    $('#btnImport_import').removeAttr('disabled');
                    $('#btnImport2').removeAttr('disabled');
                    
                } else {	
                	$('#txtDatea').datepicker();
                    $('#txtBdate').datepicker();
                    $('#txtEdate').datepicker();
                    $('#btnImport_import').attr('disabled','disabled');
                    $('#btnImport2').attr('disabled','disabled');
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
                overflow: hidden;
            }
            .dview {
                float: left;
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
        <div id="divImport" style="position:absolute; top:200px; left:500px; display:none; width:400px; height:200px; background-color: #cad3ff; border: 5px solid gray;">
			<table style="width:100%;">
				<tr style="height:1px;">
					<td style="width:150px;"></td>
					<td style="width:80px;"></td>
					<td style="width:80px;"></td>
					<td style="width:80px;"></td>
					<td style="width:80px;"></td>
				</tr>
				<tr style="height:35px;">
					<td><span> </span><a id="lblDatea_import" style="float:right; color: blue; font-size: medium;">日期</a></td>
					<td colspan="4">
					<input id="txtDatea_import"  type="text" style="float:left; width:100px; font-size: medium;"/>
					</td>
				</tr>
				<tr style="height:35px;">
					<td><span> </span><a id='lblGroupano_import' style="float:right; color: blue; font-size: medium;">大類群組</a></td>
					<td colspan="4"><select id="cmbGroupano_import" class="txt c1"></select> </td>
				</tr>
				<tr style="height:35px;">
					<td><span> </span><a id='lblGroupbno_import' style="float:right; color: blue; font-size: medium;">中類群組</a></td>
					<td colspan="4"><select id="cmbGroupbno_import" class="txt c1"></select> </td>
				</tr>
				<tr style="height:35px;">
					<td><span> </span><a id="lblPrice_import" style="float:right; color: blue; font-size: medium;">基價</a></td>
					<td colspan="4">
						<input id="txtPrice_import"  type="text" class="num" style="float:left; width:100px; font-size: medium;"/>
					</td>
				</tr>
				<tr style="height:35px;">
					<td> </td>
					<td>
					<input id="btnImport_import" type="button" value="修改"/>
					</td>
					<td></td>
					<td></td>
					<td>
					<input id="btnCancel_import" type="button" value="關閉"/>
					</td>
				</tr>
			</table>
		</div>
        
        <div id="dmain">
            <div class="dview" id="dview">
                <table class="tview" id="tview">
                    <tr>
                        <td align="center" style="width:20px; color:black;"><a id="vewChk"> </a></td>
                        <td align="center" style="width:150px; color:black;"><a id="vewDatea">基價日期</a></td>
                    </tr>
                    <tr>
                        <td><input id="chkBrow.*" type="checkbox"/></td>
                        <td id="datea" style="text-align: center;">~datea</td>
                    </tr>
                </table>
            </div>
            <div class="dbbm">
                <table class="tbbm"  id="tbbm">
                    <tr style="height:1px;">
                        <td> </td>
                        <td> </td>
                        <td> </td>
                        <td> </td>
                        <td class="tdZ"> </td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblNoa" class="lbl"> </a></td>
                        <td><input id="txtNoa" type="text" class="txt c1"/></td>
                        <td> </td>
                        
                    </tr>
                    <tr>
                    	<td><span> </span><a id="lblDatea" class="lbl">基價日期</a></td>
                        <td><input id="txtDatea" type="text" class="txt c1"/></td>
                    </tr>
                    <tr>
                    	<td><span> </span><a id="lblEdate" class="lbl">物品區間</a></td>
                        <td colspan="2">
                        	<input id="txtBproductno" type="text" class="txt" style="width:40%;"/>
                        	<input id='btnBproductno' type='button' style='display:none'/>
                        	<span style="display:block;width:25px;float:left;">～</span>
                        	<input id="txtEproductno" type="text" class="txt" style="width:40%;"/>
                       		<input id='btnEproductno' type='button' style='display:none'/>
                        </td>
                        <td style="text-align: center;display:none;" class="fe rk"><input id="btnImport2" type="button" class="txt c1" value="群組修改"/></td>
                    </tr>
                    <tr>
                    	<td><span> </span><a id="lblEdate" class="lbl">庫存運算區間</a></td>
                        <td colspan="2">
                        	<input id="txtBdate" type="text" class="txt" style="width:40%;"/>
                        	<span style="display:block;width:25px;float:left;">～</span>
                        	<input id="txtEdate" type="text" class="txt" style="width:40%;"/>
                        </td>
                        <td style="text-align: center;display:none;" class="fe rk"><input type="button" id="btnImport" value="匯入" class="txt c1"></td>
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
                    <td align="center" style="width:20px;"> </td>
                    <td align="center" style="width:100px;"><a id='lblProductno_s'>物品編號</a></td>
  					<td align="center" style="width:150px;"><a id='lblProduct_s'>物品名稱</a></td>
  					<td align="center" class="rk" style="width:80px;display:none;"><a id='lblDime_s'>厚度</a></td>
  					<td align="center" class="rk" style="width:80px;display:none;"><a id='lblWidth_s'>寬度</a></td>
  					<td align="center" style="width:100px;"><a id='lblSprice_s'>基價</a></td>
  					<td align="center" style="width:100px;"><a id='lblLprice_s'>上次基價</a></td>
  					<td align="center" style="width:100px;"><a id='lblLdate_s'>上次基價日</a></td>
                </tr>
                
                <tr style='background:#cad3ff;'>
                    <td align="center">
	                    <input class="btn" id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
	                    <input id="txtNoq.*" type="text" style="display: none;"/>
                    </td>
                    <td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
                    <td>
                    	<input type="text" id="txtProductno.*" style="width:95%;"/>
                    	<input type="button" id="btnProductno.*" style="display:none;"/>
                    	<input type="text" id="txtDatea.*" style="display:none;"/>
                    </td>
                    <td><input type="text" id="txtProduct.*" style="width:95%;"/></td>
                    <td class="rk" style="display:none;"><input type="text" id="txtDime.*" style="width:95%;"/></td>
                    <td class="rk" style="display:none;"><input type="text" id="txtWidth.*" style="width:95%;"/></td>
                    <td><input type="text" id="txtSprice.*" style="width:95%;text-align: right;"/></td>
                    <td><input type="text" id="txtLprice.*" style="width:95%;text-align: right;"/></td>
                    <td><input type="text" id="txtLdate.*" style="width:95%;text-align: right;"/></td>
                </tr>
            </table>
        </div>
        <input id="q_sys" type="hidden" />
    </body>
</html>
