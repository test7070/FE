<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
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
		
			var t_uccga,t_custtype,t_acomp;
            $(document).ready(function() {
                q_getId();
                q_gf('', 'z_salaryfe');   
            });
            function q_gtPost(t_name) {
				switch (t_name) {
					default:                 
                        break;
				}
			}
			
            function q_gfPost() {
                $('#q_report').q_report({
                    fileName : 'z_salaryfe',
                    options : [{
						type : '0', //[1]
						name : 'path',
						value : location.protocol + '//' +location.hostname + location.pathname.toLowerCase().replace('z_salaryfe.aspx','')
					},{
						type : '0', //[2]
						name : 'db',
						value : q_db
					},{
						type : '0', //[3]
						name : 'name',
						value : r_name
					},{
						type : '1', //[4][5]   1
						name : 'xdate'
					},{
						type : '6', //[6]      2
						name : 'xtype'
					},{
						type : '2', //[7][8]   3
						name : 'xsss',
						dbf : 'sss',
						index : 'noa,namea',
						src : 'sss_b.aspx'
					},{
						type : '6', //[9]      4
						name : 'xmon'
					}]
                });
                q_popAssign();
                q_langShow();
                $('#txtXtype').attr('list','listType');
                
                $('#txtXdate1').datepicker();
                $('#txtXdate2').datepicker();
            	$('#txtXdate1').mask(r_picd);
            	$('#txtXdate2').mask(r_picd);
            	$('#txtXmon').mask(r_picm);
            }

            function q_boxClose(s2) {
            }
		</script>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
		<div id="q_menu"></div>
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;width:2000px;">
			<div id="container">
				<div id="q_report"></div>
			</div>
			<div class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
		<datalist id="listType">
        	<option value="內勤"> </option>
        	<option value="廠務"> </option>
        </datalist>
	</body>
</html>