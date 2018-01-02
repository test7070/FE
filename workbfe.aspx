<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
			this.errorHandler = null;
			function onPageError(error) {
				alert("An error occurred:\r\n" + error.Message);
			}
			q_tables = 's';
			var q_name = "workb";
			var q_readonly = ['txtNoa'];
			var q_readonlys = ['txtOrdeno'];
			var bbmNum = [['txtTotal', 10, 0, 1]];
			var bbsNum = [['txtDime', 10, 0, 1],['txtWidth', 10, 0, 1]];
			var bbmMask = [];
			var bbsMask = [];
			q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = '';
			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'noq'];
				q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
			});
			
			aPop = new Array(
			    ['txtStationno', 'lblStationno', 'sss', 'noa,namea', 'txtStationno,txtStation', 'sss_b.aspx']
			);

			function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                q_mask(bbmMask);
                mainForm(1);
                $('#txtDatea').focus();
            }
            
            function sum() {
                var t_money=0;
                for (var j = 0; j < q_bbsCount; j++) { 
                   switch ($('#cmbTypea').val()){
                        case '1':
                            $('#txtWidth_'+j).val(q_mul(q_div($('#txtPert').val(),100),$('#txtDime_'+j).val())); 
                        default:
                            $('#txtWidth_'+j).val(q_float('txtWidth_' + j)); 
                            break;
                   }   
                   t_money=q_add(t_money, q_float('txtWidth_' + j));
                }
                $('#txtTotal').val(t_money);
            }

			function mainPost() {
				q_getFormat();
				bbmMask = [['txtDatea', r_picd],['txtBdate', r_picd],['txtEdate', r_picd],['txtTime', r_picd]];
				bbsMask = [['txtDatea', r_picd]];
				q_mask(bbmMask);
				q_cmbParse("cmbTypea",'1@介紹,2@共享業務,3@居家業務,4@居家專職業務,5@在職專職業務');
				q_cmbParse("cmbWorkno",'1@由公司報價,2@自主報價');
				q_cmbParse("cmbWorktime",'@,1@是,2@否');
				q_cmbParse("cmbWorkbqno",'@,1@是,2@否');
				q_cmbParse("cmbWorkano",'@,1@無,2@保障最低薪資,3@保障7個月最低薪資');
				q_cmbParse("cmbMechno",'@,1@入門級（初期入會的會員）,2@銀級（成交3個5萬元以上案件+交貨收款完成）,3@金級（成交10個5萬元案件+交貨收款完成）,4@鑽石級（成交20個5萬元以上案件+交貨收款完成),5@鼎級（成交40個5萬元以上案件+交貨收款完成）');
			    q_cmbParse("cmbMech",'@,1@抽傭金,2@抽毛利,3@參照現有居家業務獎金制度 * 1.2,4@參照現有居家業務獎金制度 * 1.4,5@參照現有居家業務獎金制度 * 1.6,6@參照現有居家業務獎金制度 * 1.8,7@參照現有居家業務獎金制度 * 2,8@參照現有居家業務獎懲制度,9@參照現有居家業務制度,10@參照現有業務制度');
			    q_cmbParse("cmbTeam",'@,1@只有獎金明細,2@有公司程式密碼+只可以看自己的客戶交易明細及產品資料,3@需進公司開會+有公司程式密碼+只可以看自己的客戶交易明細及產品資料,4@配手機+需進公司開會+知道基價+有公司程式密碼,5@配手機+勞健保+勞退+誠信險+可收款+需進公司開會+需隨時讓公司找到+知道基價+有公司程式密碼,6@配車+配手機+勞健保+勞退+誠信險+可收款+需進公司開會+需隨時讓公司找到+知道基價+有公司程式密碼');

			    $('#cmbMech').change(function() {
                    if($('#cmbMech').val()=='1'){
                        $('.isMech').show();
                        $('#lblBonus_st').text('抽傭金');
                    }else if($('#cmbMech').val()=='2'){
                        $('.isMech').show();
                        $('#lblBonus_st').text('抽毛利');
                    }else{
                        $('.isMech').hide();
                    }
                });
                
                $('#btnPrice').click(function() {
                    q_box("uccp.aspx?" + r_userno + ";" + r_name + ";" + q_time, 'uccp', "95%", "650px", q_getMsg('popUccp'));
                });
                
                $('#cmbTypea').change(function() {
                    $('#txtTelfee').val('');
                    $('#txtSalary').val('');
                    $('#txtPert').val('');
                    $('.isFee').hide();
                    switch ($('#cmbTypea').val()){
                        case '1':
                            $('.isSal').hide();
                            $('#cmbWorkno').val('1');
                            $('#cmbMechno').val('');
                            $('#cmbMech').val('');
                            $('#cmbWorktime').val('');
                            $('#cmbWorkano').val('');
                            $('#cmbWorkbqno').val('');
                            $('#cmbTeam').val('');
                            $('#txtSalary').val('28000'); 
                            break;
                        case '2':
                            $('.isSal').hide();
                            $('.isMech').hide();
                            var t_salesno = $('#txtStationno').val();
                            q_func('qtxt.query.salelevel', 'workbfe.txt,salelevel,'+ encodeURI(t_salesno)); 
                            break;
                        case '3':
                            $('.isSal').show();
                            $('.isMech').hide();
                            $('#cmbWorkno').val('2');
                            $('#cmbMechno').val('');
                            $('#cmbMech').val('8');
                            $('#cmbWorktime').val('1');
                            $('#cmbWorkano').val('2');
                            $('#cmbWorkbqno').val('');
                            $('#cmbTeam').val('5');
                            break;
                        case '4':
                            $('.isSal').show();
                            $('.isMech').hide();
                            $('#cmbWorkno').val('2');
                            $('#cmbMechno').val('');
                            $('#cmbMech').val('9');
                            $('#cmbWorktime').val('2');
                            $('#cmbWorkano').val('3');
                            $('#cmbWorkbqno').val('');
                            $('#cmbTeam').val('6');
                            $('#txtSalary').val('28000'); 
                            break;
                        case '5':
                            $('.isSal').show();
                            $('.isMech').hide();
                            $('#cmbWorkno').val('2');
                            $('#cmbMechno').val('');
                            $('#cmbMech').val('10');
                            $('#cmbWorktime').val('2');
                            $('#cmbWorkano').val('3');
                            $('#cmbWorkbqno').val('');
                            $('#cmbTeam').val('6');
                            $('#txtSalary').val('31000');
                            break;
                        default:
                            $('#cmbWorkno').val('1'); 
                            break;
                    }
                });
                
                $('#cmbMechno').change(function() {
                    $('#txtTelfee').val('');
                    $('#txtSalary').val('');
                    switch ($('#cmbMechno').val()){
                        case '1':
                            $('.isFee').hide();
                            $('#cmbWorkno').val('1'); 
                            $('#cmbMech').val('3');
                            $('#cmbWorktime').val('');
                            $('#cmbWorkano').val('1');
                            $('#cmbWorkbqno').val('1');
                            $('#cmbTeam').val('1');
                            break;
                        case '2':
                            $('.isFee').hide();
                            $('#cmbWorkno').val('1'); 
                            $('#cmbMech').val('4');
                            $('#cmbWorktime').val('');
                            $('#cmbWorkano').val('1');
                            $('#cmbWorkbqno').val('1');
                            $('#cmbTeam').val('1');
                            break;
                        case '3':
                            $('.isFee').show();
                            $('#cmbWorkno').val('1'); 
                            $('#cmbMech').val('5');
                            $('#cmbWorktime').val('');
                            $('#cmbWorkano').val('1');
                            $('#cmbWorkbqno').val('1');
                            $('#cmbTeam').val('2');
                            $('#txtTelfee').val('500');
                            break;
                        case '4':
                            $('.isFee').show();
                            $('#cmbWorkno').val('1'); 
                            $('#cmbMech').val('6');
                            $('#cmbWorktime').val('');
                            $('#cmbWorkano').val('1');
                            $('#cmbWorkbqno').val('1');
                            $('#cmbTeam').val('3');
                            $('#txtTelfee').val('1000');
                            break;
                        case '5':
                            $('.isFee').hide();
                            $('#cmbWorkno').val('2'); 
                            $('#cmbMech').val('7');
                            $('#cmbWorktime').val('');
                            $('#cmbWorkano').val('1');
                            $('#cmbWorkbqno').val('1');
                            $('#cmbTeam').val('4');
                            break;
                        default:
                            $('.isFee').hide();
                            $('#cmbWorkno').val('1');
                            $('#cmbMechno').val('');
                            $('#cmbMech').val('');
                            $('#cmbWorktime').val('');
                            $('#cmbWorkano').val('');
                            $('#cmbWorkbqno').val('');
                            $('#cmbTeam').val(''); 
                            break;
                    }
                });
                
                $('#btnImport').click(function(e){
                    var t_bdate = $('#txtBdate').val();
                    var t_edate = $('#txtEdate').val();
                    var t_salesno = $('#txtStationno').val();
                    if(t_bdate.length==0 || t_edate.length==0){
                        alert('請輸入日期。');
                        return;
                    }
                    q_func('qtxt.query.workbfe_vcc', 'workbfe.txt,import,' + encodeURI(t_bdate) + ';' + encodeURI(t_edate)+ ';' + encodeURI(t_salesno));     
                });
			}

			function q_funcPost(t_func, result) {
                switch(t_func) {
                    case 'qtxt.query.salelevel':
                        var as = _q_appendData("tmp0", "", true, true);
                        if (as[0] != undefined) {
                            $('#cmbMechno').val(as[0].mechno);
                            $('#cmbMech').val(as[0].mech);
                            $('#cmbWorkno').val(as[0].workno);
                            $('#cmbWorkbqno').val(as[0].workbqno);
                            $('#cmbWorkano').val(as[0].workano);
                            $('#cmbTeam').val(as[0].team);
                        } else {
                            $('#cmbWorkno').val('1');
                            $('#cmbMechno').val('');
                            $('#cmbMech').val('');
                            $('#cmbWorkano').val('');
                            $('#cmbWorkbqno').val('');
                            $('#cmbTeam').val('');
                            $('#cmbWorktime').val('');
                        }
                        Unlock(1);
                        break;
                    case 'qtxt.query.workbfe_vcc':
                        var as = _q_appendData("tmp0", "", true, true);
                        if (as[0] != undefined) {
                            q_gridAddRow(bbsHtm, 'tbbs', 'txtDatea,txtDime,chkEnda,txtOrdeno'
                            , as.length, as, 'datea,money,enda,noa', 'txtDatea,txtDime,txtOrdeno','');
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
				switch (t_name){
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
				}
			}

			function q_stPost() {
				if (!(q_cur == 1 || q_cur == 2))
					return false;
				Unlock();
			}

			function btnOk() {
				Lock();
				var t_date = $('#txtDatea').val();
				var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
                var t_date = $('#txtDatea').val();

                //共享業務等級沒有Key且入月3個月以上
                var t_timea;
                if(r_len=='4'){
                     t_timea=q_cdn(q_date(),-93).substr(0,r_lenm)+q_date().substr(7,3); 
                }else{
                     t_timea=q_cdn(q_date(),-93).substr(0,r_lenm)+q_date().substr(6,3);
                }
                if($('#cmbTypea').val()=='2' && $('#cmbMechno').val().length==0 && $('#txtTime').val().length!=0 && t_timea>$('#txtTime').val()){
                      $('.isFee').hide();
                      $('#cmbMechno').val('1');
                      $('#cmbWorkno').val('1'); 
                      $('#cmbMech').val('3');
                      $('#cmbWorktime').val('');
                      $('#cmbWorkano').val('1');
                      $('#cmbWorkbqno').val('1');
                      $('#cmbTeam').val('1');
                }                  
                if (q_cur == 1)
                    $('#txtWorker').val(r_name);
                else
                    $('#txtWorker2').val(r_name);
              
                sum();
                      
                
                if (s1.length == 0 || s1 == "AUTO")
                     q_gtnoa(q_name, replaceAll(q_getPara('sys.key_workb') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                        wrServer(s1);
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;
			}

			function btnIns() {
				 _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtDatea').val(q_date);
                $('#txtDatea').focus();
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
			}

			function btnPrint() {
			}

			function wrServer(key_value) {
				var i;
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
			}

			function bbsAssign() {
				for (var i = 0; i < q_bbsCount; i++) {
					if (!$('#btnMinus_' + i).hasClass('isAssign')) {
					   $('#txtWidth_' + i).change(function() {
                            sum();
                       });
                       
                       $('#txtOrdeno_'+i).bind('contextmenu',function(e) {
                            /*滑鼠右鍵*/
                            e.preventDefault();
                            var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                            if($('#cmbTypea').val()!='1' && (($('#cmbTypea').val()=='2' && $('#cmbMechno').val()!='1' && $('#cmbMechno').val()!='2'))){
                                q_box("vcc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";noa='" + $(this).val() + "';" + r_accy, 'vcc', "95%", "95%", q_getMsg("popvcc"));
                            }
                        });
					}
				}
				_bbsAssign();
			}

			function bbsSave(as) {
				t_err = '';
				if (!as['datea'] && !as['dime']) {
                    as[bbsKey[1]] = '';
                    return;
                }
				q_nowf();
				as['noa'] = abbm2['noa'];
				if (t_err) {
					alert(t_err)
					return false;
				}
				return true;
			}

			function refresh(recno) {
				_refresh(recno);

                if($('#cmbMech').val()=='1'){
                    $('.isMech').show();
                    $('#lblBonus_st').text('抽傭金');
                }else if($('#cmbMech').val()=='2'){
                    $('.isMech').show();
                    $('#lblBonus_st').text('抽毛利');
                }else{
                    $('.isMech').hide();
                }
                
                if($('#cmbWorkano').val()=='2' || $('#cmbWorkano').val()=='3'){
                    $('.isSal').show();
                }else{
                    $('.isSal').hide();
                }

                if($('#cmbMechno').val()=='3' || $('#cmbMechno').val()=='4'){
                     $('.isFee').show();
                }else{
                     $('.isFee').hide();
                }
                
                if($('#cmbMechno').val()=='5' || $('#cmbTypea').val()=='3' || $('#cmbTypea').val()=='4' || $('#cmbTypea').val()=='5'){
                     $('#btnPrice').show();
                }else{
                     $('#btnPrice').hide();                     
                }
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
				width: 400px;
				border-width: 0px;
			}
			.tview {
				border: 5px solid gray;
				font-size: medium;
				background-color: black;
				width: 100%;
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
				width: 800px;
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
				width: 95%;
				float: left;
			}
			.txt.c2 {
				width: 25%;
				float: left;
			}
			.txt.c3 {
				width: 50%;
				float: left;
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
				width: 100%;
			}
			.dbbs {
				width: 800px;
			}
			.tbbs a {
				font-size: medium;
			}
			.num {
				text-align: right;
			}
			input[type="text"], input[type="button"] {
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
                        <td align="center" style="width:5%"><a id='vewChk'> </a></td>
                        <td align="center" style="width:20%"><a id='vewDatea_bq'>日期</a></td>
                        <td align="center" style="width:20%"><a id='vewStation_bq'>業務</a></td>
                        <td align="center" style="width:40%"><a id='vewNoa_bq'> </a>出貨單日期</td>
                    </tr>
                    <tr>
                        <td ><input id="chkBrow.*" type="checkbox" style=''/></td>
                        <td align="center" id='datea'>~datea</td>
                        <td align="center" id='station'>~station</td>
                        <td id="bdate edate" style="text-align: center;">~bdate - ~edate</td>
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
                        <td class="td1"><span> </span><a id='lblDatea_st' class="lbl">日期</a></td>
                        <td class="td2"><input id="txtDatea" type="text" class="txt c1"/></td>
                        <td class="td4"><span> </span><a id='lblNoa_st' class="lbl">單據編號</a></td>
                        <td class="td5"><input id="txtNoa" type="text" class="txt c1" /></td>
                        <td> <input id="btnPrice" type="button" value="基價"/></td>
                    </tr>
                    <tr>
                        <td class="td1"><span> </span><a id='lblStationno' class="lbl btn">業務</a></td>
                        <td class="td2"><input id="txtStationno" type="text" class="txt c3"/>
                                        <input id="txtStation" type="text" class="txt c3" /></td>
                        <td class="td5"><span> </span><a id='lblType' class="lbl"> </a></td>
                        <td class="td6"><select id="cmbTypea"> </select></td>
                        <td class="td3"><span> </span><a id='lblTime_fe' class="lbl">入會日期</a></td>
                        <td class="td4"><input id="txtTime" type="text" class="txt c1"/></td>
                    </tr>
                    <tr>
                        <td class="td1"><span> </span><a id='lblWorkno_st' class="lbl">報價</a></td>
                        <td class="td2"><select id="cmbWorkno"> </select></td>
                        <td class="td3"><span> </span><a id='lblMechno_st' class="lbl">等級</a></td>
                        <td class="td4" colspan="3"><select id="cmbMechno"> </select></td>
                    </tr>
                    <tr>
                        <td class="td1"><span> </span><a id='lblMech_st' class="lbl">獎金制度類型</a></td>
                        <td class="td2" colspan="3"><select id="cmbMech"> </select></td>
                        <td class="td5 isMech"><span> </span><a id='lblBonus_st' class="lbl"> </a></td>
                        <td class="td6 isMech"><input id="txtPert" type="text" class="txt c3"/> %</td>
                    </tr>
                    <tr>
                        <td class="td1"><span> </span><a id='lblWorktime_st' class="lbl">兼職</a></td>
                        <td class="td2"><select id="cmbWorktime"> </select></td>
                        <td class="td3"><span> </span><a id='lblWorkano_st' class="lbl">保障薪資</a></td>
                        <td class="td4" colspan="2"><select id="cmbWorkano"> </select></td>
                        <td class="td6 isSal"><input id="txtSalary" type="text" class="txt c3"/>/月</td>
                    </tr>
                    <tr>
                        <td class="td1"><span> </span><a id='lblWorkbqno' class="lbl">客戶資料調查</a></td>
                        <td class="td2"><select id="cmbWorkbqno"> </select></td>
                        <td class="td4 isFee"><span> </span><a id='lblTelfee_st' class="lbl">電話費用補助</a></td>
                        <td class="td5 isFee"><input id="txtTelfee" type="text" class="txt c3"/>元/月</td>
                    </tr>
                    <tr>
                        <td class="td1"><span> </span><a id='lblTeam_fe' class="lbl">權責</a></td>
                        <td class="td2" colspan="5"><select id="cmbTeam"> </select></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id='lblBdate_st' class="lbl">出貨單日期</a></td>
                        <td colspan="2">
                            <input id="txtBdate" type="text" class="txt c3" style="width: 120px;"/>
                            <a style="float: left;">~</a>
                            <input id="txtEdate" type="text" class="txt c3" style="width: 120px;"/></td>
                        <td> <input id="btnImport" type="button" value="匯入"/></td>
                        <td class="td5"><span> </span><a id='lblTotal_st' class="lbl">獎金總額</a></td>
                        <td class="td4"><input id="txtTotal" type="text" class="txt c1 num"/></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id='lblMemo_fe' class="lbl">備註</a></td>
                        <td colspan="5"><textarea id="txtMemo" rows='5' cols='10' style="width:99%; height: 50px;"> </textarea></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id='lblWorker' class="lbl"> </a></td>
                        <td><input id="txtWorker" type="text" class="txt c1"/></td>
                    </tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td align="center" style="width: 2%;">
						<input class="btn" id="btnPlus" type="button" value='+' style="font-weight: bold;" />
					</td>
					<td align="center" style="width:90px;"><a id='lbldatea_s'>日期</a></td>
					<td align="center" style="width:90px;"><a id='lblDime_s'>交易金額</a></td>
					<td align="center" style="width:90px;"><a id='lblWidth_s'>獎金</a></td>
					<td align="center" style="width:60px;"><a id='lblEnda_s'>交貨收款</a></td>
					<td align="center" style="width:100px;"><a id='lblVccno_s'>出貨單號</a></td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td align="center">
						<input class="btn" id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
						<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td><input id="txtDatea.*" type="text" class="txt c1"/></td>
					<td><input id="txtDime.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtWidth.*" type="text" class="txt c1 num"/></td>
					<td align="center"><input id="chkEnda.*" type="checkbox"/></td>
					<td><input id="txtOrdeno.*" type="text" class="txt c1"/></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>