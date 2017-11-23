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
		var q_name="carp";
		var q_readonly = [];
		var bbmNum = [['txtPrice',10,2,1]]; 
		var bbmMask = []; 
		q_sqlCount = 6; brwCount = 6; brwCount2=15; brwList =[] ; brwNowPage = 0 ; brwKey = 'noa';
		
		//aPop = new Array(['txtAddrno', 'lblAddr', 'addr2', 'noa,post', 'txtAddrno,txtAddr', 'addr2_b.aspx']);


		$(document).ready(function () {
			bbmKey = ['noa'];
			q_brwCount();
			q_gt(q_name, q_content, q_sqlCount, 1);
		});

		function main() {
			if (dataErr)	
			{
				dataErr = false;
				return;
			}
			mainForm(0);
		}


		function mainPost() { 
			q_mask(bbmMask);
			$('#txtNoa').change(function(e){
				$(this).val($.trim($(this).val()).toUpperCase());		
				if($(this).val().length>0){
					t_where="where=^^ noa='"+$(this).val()+"'^^";
					q_gt('carp', t_where, 0, 0, 0, "checkCarp_change", r_accy);
				}
			});
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
		}


		function q_gtPost(t_name) {  
			switch (t_name) {
				case 'checkCarp_change':
						var as = _q_appendData("carp", "", true);
						if (as[0] != undefined){
							alert('已存在 '+as[0].noa+' '+as[0].styleno+' '+as[0].addrno);
						}
						break;
				case 'checkCarp_btnOk':
						var as = _q_appendData("carp", "", true);
						if (as[0] != undefined){
							alert('已存在 '+as[0].noa+' '+as[0].styleno+' '+as[0].addrno);
							Unlock();
							return;
						}else{
							wrServer($('#txtNoa').val());
						}
						break;
				case q_name: if (q_cur == 4)	
						q_Seek_gtPost();
					break;
			}
		}
		
		function _btnSeek() {
			if (q_cur > 0 && q_cur < 4)  // 1-3
				return;
			q_box('carp_s.aspx', q_name + '_s', "500px", "300px", q_getMsg( "popSeek"));
		}
		function btnIns() {
			_btnIns();
			refreshBbm();
			$('#txtNoa').focus();
		}

		function btnModi() {
			if (emp($('#txtNoa').val()))
				return;
			_btnModi();
			refreshBbm();
			$('#txtStyleno').focus();
		}

		function btnPrint() {
 
		}
		function q_stPost() {
			if (!(q_cur == 1 || q_cur == 2))
				return false;
			Unlock();
		}
		function btnOk() {
			Lock(); 
			if(q_cur==1){
				t_where="where=^^ noa='"+$('#txtNoa').val()+"'^^";
				q_gt('carp', t_where, 0, 0, 0, "checkCarp_btnOk", r_accy);
			}else{
				wrServer($('#txtNoa').val());
			}
		 }

		function wrServer( key_value) {
			var i;
			xmlSql = '';
			if (q_cur == 2)	
				xmlSql = q_preXml();

			$('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
			_btnOk(key_value, bbmKey[0], '','',2);
		}

		function refresh(recno) {
			_refresh(recno);
			 refreshBbm();
		}
		function refreshBbm(){
				if(q_cur==1){
					$('#txtNoa').css('color','black').css('background','white').removeAttr('readonly');
				}else{
					$('#txtNoa').css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
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

		function btnSeek(){
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
                width: 300px;
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
                width: 1400px;
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
		<div id="dmain">
            <div class="dview" id="dview">
                <table class="tview" id="tview">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>				
						<td align="center" style="display:none;"><a id='vewNoa'> </a></td>
						<td align="center" style="width:25%"><a id='vewStyleno'>運費型態</a></td>
						<td align="center" style="width:25%"><a id='vewAddrno'>運送區域</a></td>
						<td align="center" style="width:25%"><a id='vewPrice'>單價</a></td>
					</tr>
					 <tr>
						<td ><input id="chkBrow.*" type="checkbox" style=''/> </td>
						<td align="center" id='noa' style="display:none;">~noa</td>
						<td align="center" id='styleno'>~styleno</td>
						<td align="center" id='addrno'>~addrno</td>
						<td align="center" id='price'>~price</td>
					</tr>
				</table>
			</div>
			<div class="dbbm">
                <table class="tbbm"  id="tbbm">
                    <tr style="height:1px;">
                        <td></td>
                        <td></td>
                        <td></td>
                        <td class="tdZ"> </td>
                    </tr>
		 			<tr>
						<td><span> </span><a id='lblNoa' class="lbl">編號</a></td>
						<td><input id="txtNoa"  type="text"  class="txt c1"/></td>
						<td> </td>
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblStyleno' class="lbl">運費型態</a></td>
						<td><input id="txtStyleno"  type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAddrno' class="lbl">運送區域</a></td>
						<td><input id="txtAddrno"  type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblPrice' class="lbl">單價</a></td>
						<td><input id="txtPrice"  type="text"  class="txt c1 num"/></td>
					</tr>
					<tr> </tr>
				</table>
			</div>
		</div> 
		<input id="q_sys" type="hidden" />	
	</body>
</html>