<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta http-equiv="Content-Language" content="en-us" />
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src="../script/qj2.js" type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src="../script/qj_mess.js" type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
            //匯入ordcfe
            
            var q_name = "vcc_orde_fe", t_content = "where=^^['','','','')^^", bbsKey = ['tablea','tableaccy','noa','noq'], as;
            var isBott = false;
            var txtfield = [], afield, t_data, t_htm, t_bbsTag = 'tbbs';
       		brwCount = -1;
			brwCount2 = -1;
            $(document).ready(function() {
                main();
            });

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                var t_para = new Array();
	            try{
	            	t_para = JSON.parse(decodeURIComponent(q_getId()[5]));
	            	t_content = "where=^^['"+t_para.custno+"','"+t_para.vccno+"','"+t_para.para+"')^^";
	            }catch(e){
	            }    
                brwCount = -1;
                mainBrow(0, t_content);
            }
			function mainPost() {
				$('#btnTop').hide();
				$('#btnPrev').hide();
				$('#btnNext').hide();
				$('#btnBott').hide();
				
				$('#checkAllCheckbox').click(function(e){
					$('.ccheck').prop('checked',$(this).prop('checked'));
				});
			}
            function q_gtPost(t_name) {
				switch (t_name) {
					case q_name:
						abbs = _q_appendData(q_name, "", true,1);
						isLoadGt = 0;
						refresh();
						break;
				}
			}

            function refresh() {
                _refresh();
            }
		</script>
		<style type="text/css">
		</style>
	</head>


							
	<body>
		<div  id="dFixedTitle" style="overflow-y: scroll;">
			<table id="tFixedTitle" class='tFixedTitle'  border="2"  cellpadding='2' cellspacing='1' style='width:100%;'  >
				<tr style='color:white; background:#003366;' >
					<th align="center" style="width:2%;"><input type="checkbox" id="checkAllCheckbox"/></th>
					<td align="center" style="width:5%;">客戶</td>
					<td align="center" style="width:5%;">品號</td>
					<td align="center" style="width:10%;">品名</td>
					<td align="center" style="width:5%;">單位</td>
					<td align="center" style="width:5%;">數量</td>
					<td align="center" style="width:5%;">重量</td>
					<td align="center" style="width:5%;">單價</td>
					<td align="center" style="width:5%;">未交數量</td>
					<td align="center" style="width:5%;">未交重量</td>
					<td align="center" style="width:5%;">預交日期</td>
					<td align="center" style="width:10%;">訂單號碼</td>
				</tr>
			</table>
		</div>
		<div id="dbbs" style="overflow: scroll;height:450px;" >
			<table id="tbbs" class='tbbs' border="2" cellpadding='2' cellspacing='1' style='width:100%;' >
				<tr style="display:none;">
					<th align="center" style="width:2%;"></th>
					<td align="center" style="width:5%;">客戶</td>
					<td align="center" style="width:5%;">品號</td>
					<td align="center" style="width:10%;">品名</td>
					<td align="center" style="width:5%;">單位</td>
					<td align="center" style="width:5%;">數量</td>
					<td align="center" style="width:5%;">重量</td>
					<td align="center" style="width:5%;">單價</td>
					<td align="center" style="width:5%;">未交數量</td>
					<td align="center" style="width:5%;">未交重量</td>
					<td align="center" style="width:5%;">預交日期</td>
					<td align="center" style="width:10%;">訂單號碼</td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td style="width:2%;"><input type="checkbox" class="ccheck" id="chkSel.*"/></td>
					<td style="width:5%;">
						<input id="txtNick.*" type="text" style="float:left;width:95%;"  readonly="readonly" />
						<input id="txtCustno.*" type="text" style="display:none;"  readonly="readonly" />
						<input id="txtComp.*" type="text" style="display:none;"  readonly="readonly" />
					</td>
					<td style="width:5%;"><input id="txtProductno.*" type="text" style="float:left;width:100%;"  readonly="readonly" /></td>
					<td style="width:5%;"><input id="txtProduct.*" type="text" style="float:left;width:100%;"  readonly="readonly" /></td>
					
					<td style="width:5%;"><input id="txtUnit.*" type="text" style="float:left;width:100%;"  readonly="readonly" /></td>
					<td style="width:5%;"><input id="txtMount.*" type="text" style="float:left;width:100%;"  readonly="readonly" /></td>
					<td style="width:5%;"><input id="txtWeight.*" type="text" style="float:left;width:100%;"  readonly="readonly" /></td>
					<td style="width:5%;"><input id="txtPrice.*" type="text" style="float:left;width:100%;"  readonly="readonly" /></td>
					<td style="width:5%;"><input id="txtEmount.*" type="text" style="float:left;width:100%;"  readonly="readonly" /></td>
					<td style="width:5%;"><input id="txtEweight.*" type="text" style="float:left;width:100%;"  readonly="readonly" /></td>
					<td style="width:5%;"><input id="txtDatea.*" type="text" style="float:left;width:100%;"  readonly="readonly" /></td>
				</tr>
			</table>
		</div>
		<!--#include file="../inc/pop_ctrl.inc"-->
	</body>
</html>

