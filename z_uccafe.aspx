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
                q_gt('uccga', '', 0, 0, 0, "");
            });
            function q_gtPost(t_name) {
				switch (t_name) {
					case 'uccga':
                        var as = _q_appendData("uccga", "", true);
						t_uccga = " @全部";
                        for ( i = 0; i < as.length; i++) {
                            t_uccga = t_uccga + (t_uccga.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].noa +' . '+as[i].namea;
                        }	
                        q_gt('custtype', '', 0, 0, 0, "");					
                        break;
					case 'custtype':
                        var as = _q_appendData("custtype", "", true);
                        t_custtype = " @全部";
                        for ( i = 0; i < as.length; i++) {
                            t_custtype = t_custtype + (t_custtype.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].noa +' . '+as[i].namea;
                        }	
                        q_gt('acomp', '', 0, 0, 0, "");					
						break;
                    case 'acomp':
                        var as = _q_appendData("acomp", "", true);
                        t_acomp = " @全部";
                        for ( i = 0; i < as.length; i++) {
                            t_acomp = t_acomp + (t_acomp.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].acomp;
                        }  
                        q_gf('', 'z_uccafe');                  
                        break;
				}
			}
			
            function q_gfPost() {
                $('#q_report').q_report({
                    fileName : 'z_uccafe',
                    options : [{
                        type : '1', //[1][2] 1
                        name : 'date'
                    }, {
                        type : '2', //[3][4] 2
                        name : 'xsss',
                        dbf : 'sss',
                        index : 'noa,namea',
                        src : 'sss_b.aspx'
                    }, {
                        type : '2', //[5][6] 3
                        name : 'xcust',
                        dbf : 'cust',
                        index : 'noa,comp',
                        src : 'cust_b.aspx'
                    }, {
                        type : '2', //[7][8] 4
                        name : 'xucc',
                        dbf : 'ucc',
                        index : 'noa,product',
                        src : 'ucc_b.aspx'
                    }, {//產品群組
                        type : '5', //[9]   5
                        name : 'xuccga',
                        value : t_uccga.split(',')
					}, {//業務群組
                        type : '6', //[10]  6
                        name : 'xsalesgroup'
					}, {//銷貨類別
                        type : '5', //[11]  7
                        name : 'xcusttype',
                        value : t_custtype.split(',')
					}, {//公司
						type : '5', //[12]  8
						name : 'xacomp',
						value : t_acomp.split(',')
					}]
                });
                q_popAssign();
                q_langShow();
                
                $('#txtDate1').mask('999/99/99');
                $('#txtDate1').datepicker();
                $('#txtDate2').mask('999/99/99');
                $('#txtDate2').datepicker();

                var t_date, t_year, t_month, t_day;
                t_date = new Date();
                t_date.setDate(1);
                t_year = t_date.getUTCFullYear() - 1911;
                t_year = t_year > 99 ? t_year + '' : '0' + t_year;
                t_month = t_date.getUTCMonth() + 1;
                t_month = t_month > 9 ? t_month + '' : '0' + t_month;
                t_day = t_date.getUTCDate();
                t_day = t_day > 9 ? t_day + '' : '0' + t_day;
                $('#txtDate1').val(t_year + '/' + t_month + '/' + t_day);

                t_date = new Date();
                t_date.setDate(35);
                t_date.setDate(0);
                t_year = t_date.getUTCFullYear() - 1911;
                t_year = t_year > 99 ? t_year + '' : '0' + t_year;
                t_month = t_date.getUTCMonth() + 1;
                t_month = t_month > 9 ? t_month + '' : '0' + t_month;
                t_day = t_date.getUTCDate();
                t_day = t_day > 9 ? t_day + '' : '0' + t_day;
                $('#txtDate2').val(t_year + '/' + t_month + '/' + t_day);
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
	</body>
</html>