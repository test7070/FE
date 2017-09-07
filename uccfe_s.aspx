<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
            var q_name = "uccfe_s";
            aPop = new Array(['txtNoa', '', 'ucc', 'noa,product', 'txtNoa', "ucc_b.aspx"]);
            var t_groupano='',t_groupbno='';
            
            $(document).ready(function() {
                main();
            });

            function main() {
                mainSeek();
                q_gt('uccga', '', 0, 0, 0, "");
            }
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
						q_gt('uccgb', '', 0, 0, 0, "");
						break;
					case 'uccgb':
						var as = _q_appendData("uccgb", "", true);
						if (as[0] != undefined) {
							t_groupbno = " @ ";
							for ( i = 0; i < as.length; i++) {
								t_groupbno = t_groupbno + (t_groupbno.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].noa+' . '+as[i].namea;
							}
						}
						q_gf('', q_name);
						break;
                    default:
                        break;
                }
            }
            function q_gfPost() {
                q_getFormat();
                q_langShow();
                
                if(t_groupano.length>0)
                	q_cmbParse("cmbGroupano", t_groupano);
				if(t_groupbno.length>0)
                	q_cmbParse("cmbGroupbno", t_groupbno);

                $('#txtNoa').focus();
            }

            function q_seekStr() {
                t_noa = $.trim($('#txtNoa').val());
                t_product = $.trim($('#txtProduct').val());
				t_groupano = $.trim($('#cmbGroupano').val());
				t_groupbno = $.trim($('#cmbGroupbno').val());
				
                var t_where = " 1=1 " 
                	+ q_sqlPara2("noa", t_noa)
                	+ q_sqlPara2("groupano", t_groupano)
                	+ q_sqlPara2("groupbno", t_groupbno);
				if (t_product.length>0)
                    t_where += " and charindex('" + t_product + "',product)>0";
                t_where = ' where=^^' + t_where + '^^ ';
                return t_where;
            }
		</script>
		<style type="text/css">
            .seek_tr {
                color: white;
                text-align: center;
                font-weight: bold;
                BACKGROUND-COLOR: #76a2fe
            }
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
		<div style='width:400px; text-align:center;padding:15px;' >
			<table id="seek"  border="1"   cellpadding='3' cellspacing='2' style='width:100%;' >
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblNoa'></a></td>
					<td>
					<input class="txt" id="txtNoa" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblProduct'></a></td>
					<td>
					<input class="txt" id="txtProduct" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblGroupano'>大類群組</a></td>
					<td><select id="cmbGroupano" style="width:215px; font-size:medium;"></select></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblGroupbno'>中類群組</a></td>
					<td><select id="cmbGroupbno" style="width:215px; font-size:medium;"></select></td>
				</tr>
			</table>
			<!--#include file="../inc/seek_ctrl.inc"-->
		</div>
	</body>
</html>
