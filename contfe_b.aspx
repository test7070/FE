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
            var q_name = "cont_workj", t_content = "where=^^['','')^^", bbsKey = ['contno'], as;
            var isBott = false;
            var txtfield = [], afield, t_data, t_htm, t_bbsTag = 'tbbs';
       		brwCount = -1;
			brwCount2 = -1;
            $(document).ready(function() {
                main();
            });
            /// end ready

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                var t_para = new Array();
	            try{
	            	t_para = JSON.parse(decodeURIComponent(q_getId()[5]));
	            	t_content = "where=^^['"+t_para.workjno+"','"+t_para.custno+"')^^";
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
						//if (isLoadGt == 1) {
							abbs = _q_appendData(q_name, "", true);
							isLoadGt = 0;
							refresh();
						//}
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
					<th align="center" style="width:2%;" ><input type="checkbox" id="checkAllCheckbox"/></th>
					<td align="center" style="width:10%;"><a id='lblContno'>合約編號</a></td>
					<td align="center" style="width:25%;"><a id='lblProduct'>品名</a></td>
					<td align="center" style="width:7%;"><a id='lblUnit'>單位</a></td>
					<td align="center" style="width:7%;"><a id='lblLengthb'>單支長</a></td>
					<td align="center" style="width:7%;"><a id='lblMount'>數量</a></td>
					<td align="center" style="width:7%;"><a id='lblWeight'>重量</a></td>
					<td align="center" style="width:7%;"><a id='lblPrice'>單價</a></td>
					<td align="center" style="width:7%;"><a id='lblTotal'>小計</a></td>
					<td align="center" style="width:7%;"><a id='lblXmount'>未訂數量</a></td>
					<td align="center" style="width:7%;"><a id='lblXweight'>未訂重量</a></td>
				</tr>
			</table>
		</div>
		<div id="dbbs" style="overflow: scroll;height:450px;" >
			<table id="tbbs" class='tbbs' border="2" cellpadding='2' cellspacing='1' style='width:100%;' >
				<tr style="display:none;">
					<th align="center" style="width:2%;"></th>
					<td align="center" style="width:10%;"><a id='lblContno'> </a></td>
					<td align="center" style="width:25%;"><a id='lblProduct'> </a></td>
					<td align="center" style="width:7%;"><a id='lblUnit'> </a></td>
					<td align="center" style="width:7%;"><a id='lblLengthb'> </a></td>
					<td align="center" style="width:7%;"><a id='lblMount'> </a></td>
					<td align="center" style="width:7%;"><a id='lblWeight'> </a></td>
					<td align="center" style="width:7%;"><a id='lblPrice'> </a></td>
					<td align="center" style="width:7%;"><a id='lblTotal'> </a></td>
					<td align="center" style="width:7%;"><a id='lblXmount'> </a></td>
					<td align="center" style="width:7%;"><a id='lblXweight'> </a></td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td style="width:2%;"><input type="checkbox" class="ccheck" id="chkSel.*"/></td>
					<td style="width:10%;"><input class="txt" id="txtContno.*" type="text" style="width:98%;"  readonly="readonly" />
						<input class="txt" id="txtContnoq.*" type="text" style="display:none;"  readonly="readonly" />
					</td>
					<td style="width:25%;"><input class="txt" id="txtProductno.*" type="text" style="width:35%;"  readonly="readonly" />
						<input class="txt" id="txtProduct.*" type="text" style="width:55%;"  readonly="readonly" />
					</td>
					<td style="width:7%;"><input class="txt" id="txtUnit.*" type="text" style="width:98%;"  readonly="readonly" /></td>
					<td style="width:7%;"><input class="txt" id="txtLengthb.*" type="text" style="width:98%;text-align: right;"  readonly="readonly" /></td>
					<td style="width:7%;"><input class="txt" id="txtMount.*" type="text" style="width:98%;text-align: right;"  readonly="readonly" /></td>
					<td style="width:7%;"><input class="txt" id="txtWeight.*" type="text" style="width:98%;text-align: right;"  readonly="readonly" /></td>
					<td style="width:7%;"><input class="txt" id="txtPrice.*" type="text" style="width:98%;text-align: right;"  readonly="readonly" /></td>
					<td style="width:7%;"><input class="txt" id="txtTotal.*" type="text" style="width:98%;text-align: right;"  readonly="readonly" /></td>
					<td style="width:7%;"><input class="txt" id="txtXmount.*" type="text" style="width:98%;text-align: right;"  readonly="readonly" /></td>
					<td style="width:7%;"><input class="txt" id="txtXweight.*" type="text" style="width:98%;text-align: right;"  readonly="readonly" /></td>
				</tr>
			</table>
		</div>
		<!--#include file="../inc/pop_ctrl.inc"-->
	</body>
</html>

