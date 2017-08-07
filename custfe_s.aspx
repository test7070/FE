<%@ Page Language="C#" Debug="true"%>
    <script language="c#" runat="server">  
		protected void Page_Load(object sender, EventArgs e)
		{
		    jwcf wcf = new jwcf();
		
		    wcf.q_content("cust", " left( $r_userno,1)!='B' or ( salesno=$r_userno or salesno='B00' or salesno='B000' or salesno='B020' or $r_rank >= 8 )");
		    
		}
	</script>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
        <link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
			var q_name = "cust_s";
			aPop = new Array(
				['txtNoa', 'lblNoa', 'cust', 'noa,comp,nick,invoicetitle', 'txtNoa', ''],
				['txtSerial', 'lblSerial', 'cust', 'serial,noa,comp,nick', 'txtSerial', ''],
				['txtSalesno', 'lblSales', 'sss', 'noa,namea', 'txtSalesno', ''],
				['txtGrpno', 'lblGrp', 'cust', 'noa,comp,nick', 'txtGrpno', '']
			);
			
			$(document).ready(function() {
				main();
			});
			
			function main() {
				mainSeek();
				q_gf('', q_name);
				
			}
			
			function q_gfPost() {
				q_getFormat();
				q_langShow();
				q_gt('custtype', '', 0, 0, 0, "custtype");
				
				$('#txtNoa').focus();
			}
			var r_where='';
			function q_gtPost (t_name) {
			 switch (t_name) {
				case 'custtype':
					var as = _q_appendData("custtype", "", true);
					var t_custtype = "@全部";
					if (as[0] != undefined) {
						for (i = 0; i < as.length; i++) {
							t_custtype += (t_custtype.length > 0 ? ',' : '') + $.trim(as[i].noa) + '@' + $.trim(as[i].namea);
						}
						
					}
					q_cmbParse("cmbTypea",t_custtype);
					break;
				}
			}

			function q_seekStr() {
				t_noa = $('#txtNoa').val();
				t_comp = $('#txtComp').val();
				t_boss = $('#txtBoss').val();
				t_serial = $('#txtSerial').val();
				t_salesno = $('#txtSalesno').val();
				t_grpno = $('#txtGrpno').val();
				t_invoicetitle = $('#txtInvoicetitle').val();
				t_memo = $('#txtMemo').val();
				t_tel = $('#txtTel').val();
				t_typea = document.getElementById('cmbTypea').value;
				
				var t_where = " 1=1 " 
					+ q_sqlPara2("serial", t_serial)
					+ q_sqlPara2("salesno", t_salesno)
					+ q_sqlPara2("grpno", t_grpno);
					
				if (t_noa.length > 0)
					t_where += " and charindex(N'" + t_noa + "',noa)>0";
				if (t_comp.length > 0)
                    t_where += " and (charindex(N'" + t_comp + "',comp)>0 or charindex(N'" + t_comp + "',nick)>0)";
                if (t_boss.length > 0)
					t_where += " and charindex(N'" + t_boss + "',boss)>0";    
                if (t_invoicetitle.length > 0)
					t_where += " and charindex(N'" + t_invoicetitle + "',invoicetitle)>0";
				if (t_memo.length > 0)
					t_where += " and charindex(N'" + t_memo + "',memo)>0";
				if (t_tel.length > 0)
					t_where += " and (charindex(N'" + t_tel + "',tel)>0 or charindex(N'" + t_tel + "',mobile)>0 or charindex(N'" + t_tel + "',fax)>0)";
				if (t_typea.length > 0)
					t_where += " and charindex(N'" + t_typea + "',typea)>0";	
				t_where = ' where=^^' + t_where +r_where+ '^^ ';
				return t_where;
			}
		</script>
		<style type="text/css">
			.seek_tr {
				color: white;
				text-align: center;
				font-weight: bold;
				background-color: #76a2fe
			}
		</style>
	</head>
	<body>
		<div style='width:400px; text-align:center;padding:15px;' >
			<table id="seek"  border="1"   cellpadding='3' cellspacing='2' style='width:100%;' >
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblNoa'> </a></td>
					<td><input class="txt" id="txtNoa" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				 <tr class='seek_tr'>
                    <td class='seek'  style="width:20%;"><a id='lblTypea'> </a>類別</td>
                    <td><select id="cmbTypea" style="width:215px; font-size:medium;" > </select></td>
                </tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblComp'> </a></td>
					<td><input class="txt" id="txtComp" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblBoss'> </a></td>
					<td><input class="txt" id="txtBoss" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblSerial'> </a></td>
					<td><input class="txt" id="txtSerial" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblSales'> </a></td>
					<td><input class="txt" id="txtSalesno" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblInvoicetitle'> </a></td>
					<td><input class="txt" id="txtInvoicetitle" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblGrp'> </a></td>
					<td><input class="txt" id="txtGrpno" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblMemo'>備註</a></td>
					<td><input class="txt" id="txtMemo" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a>電話、傳真、行動</a></td>
					<td><input class="txt" id="txtTel" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
			</table>
			<!--#include file="../inc/seek_ctrl.inc"-->
		</div>
	</body>
</html>
