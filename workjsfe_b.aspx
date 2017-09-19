<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta http-equiv="Content-Language" content="en-us" />
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src="../script/qj2.js" type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src="../script/qj_mess.js" type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
			var q_name = 'workj', t_bbsTag = 'tbbs', t_content = "", afilter = [], bbsKey = ['noa'], as;
			//, t_where = '';
			var t_sqlname = 'workjs_fe_load';
			t_postname = q_name;
			brwCount = -1;
			brwCount2 = 0;
			var isBott = false;
			var txtfield = [], afield, t_data, t_htm;
			var i, s1;
			
			$(document).ready(function() {
				if (!q_paraChk())
					return;

				main();
			});

			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainBrow(6, t_content, t_sqlname, t_postname, r_accy);
				$('#btnTop').hide();
				$('#btnPrev').hide();
				$('#btnNext').hide();
				$('#btnBott').hide();
				q_gt('mech', "", 0, 0, 0, 'mech'); 
			}

			function bbsAssign() {
				_bbsAssign();
				for (var j = 0; j < q_bbsCount; j++) {
					if(!emp($('#txtImgdata_'+j).val())){
						$('#imgPic_'+j).attr('src',$('#txtImgdata_'+j).val()).show();
					}
					
					for (var i = 0; i < z_mech.length; i++) {
						if($('#txtMech1_'+j).val()==z_mech[i].noa){
							$('#txtMech1_'+j).val(z_mech[i].mech);
						}
						if($('#txtMech2_'+j).val()==z_mech[i].noa){
							$('#txtMech2_'+j).val(z_mech[i].mech);
						}
						if($('#txtMech3_'+j).val()==z_mech[i].noa){
							$('#txtMech3_'+j).val(z_mech[i].mech);
						}
						if($('#txtMech4_'+j).val()==z_mech[i].noa){
							$('#txtMech4_'+j).val(z_mech[i].mech);
						}
						if($('#txtMech5_'+j).val()==z_mech[i].noa){
							$('#txtMech5_'+j).val(z_mech[i].mech);
						}
					}
					
				}
				$('#checkAllCheckbox').click(function() {
                    $('input[type=checkbox][id^=chkSel]').each(function() {
                            $(this).attr('checked', $('#checkAllCheckbox').is(':checked'));
                    });
                });
			}
			
			var z_mech=[];
			function q_gtPost(t_name) {
				switch (t_name) {
					case 'mech':
                		z_mech = _q_appendData("mech", "", true);
                		break;
				}
			}

			function refresh() {
				_refresh();
			}

		</script>
		<style type="text/css">
			.seek_tr {
				color: white;
				text-align: center;
				font-weight: bold;
				BACKGROUND-COLOR: #76a2fe
			}
			input[type="text"], input[type="button"] {
				font-size: medium;
			}
		</style>
	</head>
	<body>
		<div  id="dbbs"  >
			<table id="tbbs" class='tbbs'  border="2"  cellpadding='2' cellspacing='1' style='width:100%'  >
				<tr style='color:White; background:#003366;' >
					<td align="center" style="width:30px;"><input type="checkbox" id="checkAllCheckbox"/></td>
					<td align="center" style="width:110px;"><a id='lblOdate'>預交日</a></td>
					<td align="center" style="width:150px;"><a id='lblCust'>客戶</a></td>
					<td align="center" style="width:180px;"><a id='lblProduct'>品名</a></td>
					<td align="center" style="width:100px;"><a id='lblPlace'>位置</a></td>
					<td align="center" style="width:170px;"><a id='lblImgdata'>型狀</a></td>
					<td align="center" style="width:80px;"><a id='lblLengthb'>長度</a></td>
					<td align="center" style="width:80px;"><a id='lblMonnt'>數量</a></td>
					<td align="center" style="width:95px;"><a id='lblWeight'>重量</a></td>
					<td align="center" style="width:60px;"><a id='lblMech'>機台</a></td>
					<td align="center"><a id='lblMemo'>備註</a><BR><a id='lblNoa'>加工單</a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center"><input id="chkSel.*" type="checkbox"/></td>
					<td><input class="txt" id="txtOdate.*" type="text" style="width:98%; text-align:left;"/></td>
					<td>
						<input class="txt" id="txtCustno.*" type="hidden" style="width:98%; text-align:left;"/>
						<input class="txt" id="txtCust.*" type="hidden" style="width:98%; text-align:left;"/>
						<input class="txt" id="txtNick.*" type="text" style="width:98%; text-align:left;"/>
					</td>
					<td>
						<input class="txt" id="txtProductno.*" type="text" style="text-align:left;"/>
						<input class="txt" id="txtProduct.*" type="text" style="text-align:left;"/>
					</td>
					<td><input class="txt" id="txtPlace.*" type="text" style="width:98%; text-align:right;"/></td>
					<td>
						<img id="imgPic.*" src="" style="display:none;"/>
						<input class="txt" id="txtImgdata.*" type="text" style="width:98%; text-align:right;display:none;"/>
					</td>
					<td><input class="txt" id="txtLengthb.*" type="text" style="width:98%; text-align:right;"/></td>
					<td><input class="txt" id="txtMount.*" type="text" style="width:98%; text-align:right;"/></td>
					<td><input class="txt" id="txtWeight.*" type="text" style="width:98%; text-align:right;"/></td>
					<td>
						<input class="txt" id="txtMech1.*" type="text" style="width:98%; text-align:left;"/>
						<br>
						<input class="txt" id="txtMech2.*" type="text" style="width:98%; text-align:left;"/>
						<br>
						<input class="txt" id="txtMech3.*" type="text" style="width:98%; text-align:left;"/>
						<br>
						<input class="txt" id="txtMech4.*" type="text" style="width:98%; text-align:left;"/>
						<br>
						<input class="txt" id="txtMech5.*" type="text" style="width:98%; text-align:left;"/>
					</td>
					<td>
						<input class="txt" id="txtMemo.*" type="text" style="width:98%; text-align:left;"/>
						<input class="txt" id="txtNoa.*" type="text" style="width:75%;"/>
						<input class="txt" id="txtNoq.*" type="text" style="width:20%;"/>
						<input id="recno.*" type="hidden" />
					</td>
				</tr>
			</table>
			<!--#include file="../inc/pop_ctrl.inc"-->
		</div>
	</body>
</html>