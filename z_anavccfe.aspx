<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"> </script>
		<script src='../script/qj2.js' type="text/javascript"> </script>
		<script src='qset.js' type="text/javascript"> </script>
		<script src='../script/qj_mess.js' type="text/javascript"> </script>
		<script src="../script/qbox.js" type="text/javascript"> </script>
		<script src='../script/mask.js' type="text/javascript"> </script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"> </script>
		<script src="css/jquery/ui/jquery.ui.widget.js"> </script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"> </script>
		<script type="text/javascript">
			var gfrun = false;
			var uccgaItem = '';
			var custtypeItem = '';
			var t_acomp = '';
			$(document).ready(function() {
				_q_boxClose();
				q_getId();
				if(uccgaItem.length == 0){
					q_gt('uccga', '', 0, 0, 0, "");
				}
				if(custtypeItem.length == 0){
					q_gt('custtype', '', 0, 0, 0, "");
				}
				if(t_acomp.length == 0){
					q_gt('acomp', '', 0, 0, 0, "");
				}
				
			});
			
			function q_gtPost(t_name) {
				switch (t_name) {
					case 'uccga':
                        var as = _q_appendData("uccga", "", true);
						uccgaItem = " @全部";
                        for ( i = 0; i < as.length; i++) {
                            uccgaItem = uccgaItem + (uccgaItem.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].noa +' . '+as[i].namea;
                        }						
                        break;
					case 'custtype':
                        var as = _q_appendData("custtype", "", true);
                        custtypeItem = " @全部";
                        for ( i = 0; i < as.length; i++) {
                            custtypeItem = custtypeItem + (custtypeItem.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].noa +' . '+as[i].namea;
                        }						
						break;
                    case 'acomp':
                        var as = _q_appendData("acomp", "", true);
                        t_acomp = " @全部";
                        for ( i = 0; i < as.length; i++) {
                            t_acomp = t_acomp + (t_acomp.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].acomp;
                        }                    
                        break;
				}
				if (uccgaItem.length > 0 && custtypeItem.length > 0 && t_acomp.length > 0 && !gfrun) {
                	gfrun = true;
                    q_gf('', 'z_anavccfe');
                }
			}
			
			function q_gfPost() {
				$('#q_report').q_report({
					fileName : 'z_anavccfe',
					options : [{
						type : '0', //[1]
						name : 'accy',
						value : q_getId()[4]
					}, {
						type : '1', //[2][3]
						name : 'xdate'
					}, {
						type : '1', //[4][5]
						name : 'xmon'
					}, {
						type : '2', //[6][7]
						name : 'xcust',
						dbf : 'cust',
						index : 'noa,comp',
						src : 'cust_b.aspx'
					}, {
						type : '2', //[8][9]
						name : 'xsales',
						dbf : 'sss',
						index : 'noa,namea',
						src : 'sss_b.aspx'
					}, {
						type : '2', //[10][11]
						name : 'xproduct',
						dbf : 'ucaucc',
						index : 'noa,product',
						src : 'ucaucc_b.aspx'
					}, {
						type : '1', //[12][13]
						name : 'xbmon'
					}, {
						type : '1', //[14][15]
						name : 'xemon'
					}, {
						type : '6', //[16]
						name : 'xyear'
					}, {
                        type : '5', //[17]
                        name : 'xuccgroupano',
                        value : uccgaItem.split(',')
					}, {
                        type : '6', //[18]
                        name : 'xsalesgroupano'
					}, {
                        type : '5', //[19]
                        name : 'custtype',
                        value : custtypeItem.split(',')
					},{
                        type : '5', //[20]
                        name : 'vccstype',
                        value : (' @全部,'+q_getPara('vcc.stype')).split(',')
					}, {
						type : '6', //[21]
						name : 'lostdate'
					}, {
                        type : '5', //[22]
                        name : 'lostorder',
                        value : "0@交易日,1@業務".split(',')
					},{
                        type : '5', //[23]
                        name : 'vcctypea',
                        value : (' @全部,'+q_getPara('vcc.typea')).split(',')
					},{
						type : '5', //[24]
						name : 'xcno',
						value : t_acomp.split(',')
					},{
						type : '5', //[25]
						name : 'vcctax',
						value : (' @全部,'+q_getPara('sys.taxtype')).split(',')
					}]
				});
				q_popAssign();
				q_getFormat();
				q_langShow();
				
				var r_1911=1911;
				if(r_len==4){//西元年
					r_1911=0;
				}else{
					$('#txtXdate1').datepicker();
					$('#txtXdate2').datepicker();
				}
				
				$('#txtXdate1').mask(r_picd);
				$('#txtXdate2').mask(r_picd);
				$('#txtXmon1').mask(r_picm);
				$('#txtXmon2').mask(r_picm);
				
				var t_date, t_year, t_month, t_day;
                t_date = new Date();
                t_date.setDate(1);
                t_year = t_date.getUTCFullYear() - r_1911;
                t_year = t_year > 99 ? t_year + '' : '0' + t_year;
                t_month = t_date.getUTCMonth();
                t_month = t_month > 9 ? t_month + '' : '0' + t_month;
                t_day = t_date.getUTCDate();
                t_day = t_day > 9 ? t_day + '' : '0' + t_day;
                if(t_month == '00'){
                	t_year = t_year - 1;
                	t_month = '12';
                }                	
                $('#txtXdate1').val(t_year+'/'+t_month+'/'+t_day);//上個月1號
				
				$('#txtXyear').mask('9999'.substr(0,r_len));
				$('#txtXyear').val(t_year);
				$('#txtXbmon1').val(t_year+'/01').mask(r_picm);
				$('#txtXbmon2').val(t_year+'/12').mask(r_picm);
				$('#txtXemon1').val(t_year+'/01').mask(r_picm);
				$('#txtXemon2').val(t_year+'/12').mask(r_picm);
				$('#txtLostdate').val(100);
				//$('#Xuccgroupano select').css('width','150px');
				
				if(q_getPara('sys.project')!='yc'){	
					$('#q_report div div').eq(6).hide();
					$('#btnUcf').hide();
				}
				
				$('#btnUcf').click(function() {
					q_box('ucf.aspx' + "?;;;;" + r_accy, '', "450px", "200px", $('#btnUcf').val());
				});
			}

			function q_boxClose(s2) {
			}

			
		</script>
	</head>
	<body id="z_accc" ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
		<div id="q_menu"> </div>
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;width:2000px;">
			<div id="container">
				<div id="q_report"> </div>
				<input type="button" id="btnUcf" value="成本結轉" style="font-weight: bold;font-size: medium;color: red;">
			</div>
			<div class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>