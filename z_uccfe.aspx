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
			var uccgaItem = '';
			$(document).ready(function() {
				_q_boxClose();
				q_getId();
				q_gf('', 'z_uccfe');
				
				$('#q_report').click(function() {
					if (q_getPara('sys.project').toUpperCase()!='YC'){
						$('#Xcarton').hide();
					}
					if (q_getPara('sys.project').toUpperCase()=='YC' && r_rank<8){
						$('#Xshowprice').hide();
					}
				});
			});
			
			function q_gfPost() {
				$('#q_report').q_report({
					fileName : 'z_uccfe',
					options : [{
						type : '2',
						name : 'product', //[1][2]
						dbf : 'ucaucc',
						index : 'noa,product',
						src : 'ucaucc_b.aspx'
					}, {
						type : '2',
						name : 'storeno', //[3][4]
						dbf : 'store',
						index : 'noa,store',
						src : 'store_b.aspx'
					}, {
						type : '6',
						name : 'edate' //[5]
					},{
						type : '1', //[6][7]
						name : 'xdate'
					}, {
						type : '8',
						name : 'xoption01',//[8]
						value : ['倉庫明細']
					}, {
						type : '8',
						name : 'xcarton',//[9]
						value : "1@顯示箱數".split(',')
					},{
						type : '0',//[10]
						name : 'projectname',
						value : q_getPara('sys.project').toUpperCase()
					}, {
                        type : '0', //[11]
                        name : 'mountprecision',
                        value : q_getPara('vcc.mountPrecision')
                    }, {
                        type : '0', //[12]
                        name : 'weightprecision',
                        value : q_getPara('vcc.weightPrecision')
                    }, {
                        type : '0', //[13]
                        name : 'priceprecision',
                        value : q_getPara('vcc.pricePrecision')
                    }, {
						type : '8',
						name : 'xshowprice',//[14]
						value : "1@顯示單價".split(',')
					}, {
						type : '2',
						name : 'xcust', //[15][16]
						dbf : 'cust',
						index : 'noa,comp',
						src : 'cust_b.aspx'
					}, {
						type : '2',
						name : 'xsss', //[17][18]
						dbf : 'sss',
						index : 'noa,namea',
						src : 'sss_b.aspx'
					}, {
						type : '5', //[19]
						name : 'xtrantype',
						value :[q_getPara('report.all')].concat(q_getPara('fe.trantype').split(','))
					}, {
						type : '8',
						name : 'xsel',//[20]
						value : "1@僅顯示退貨,2@客戶別統計,3@業務分析,4@業務排行榜,5@中類分析".split(',')
					}]
				});
				q_popAssign();
				q_getFormat();
				q_langShow();
				
				var r_1911=1911;
				if(r_len==4){//西元年
					r_1911=0;
				}else{
					$('#txtEdate').datepicker();
					$('#txtXdate1').datepicker();
					$('#txtXdate2').datepicker();
				}

				$('#txtEdate').mask(r_picd);
				$('#txtEdate').val(q_date());
				$('#txtXdate1').mask(r_picd);
				$('#txtXdate2').mask(r_picd);
				
				$('#Xoption01').css('width','300px').css('height','30px');
				$('#chkXoption01').css('width','215px');
				$('#chkXoption01 span').css('width','175px');
				$('#Xcarton').css('width','300px').css('height','30px');
				$('#chkXcarton').css('width','215px');
				$('#chkXcarton span').css('width','175px');
				$('#Xshowprice').css('width','300px').css('height','30px');
				$('#chkXshowprice').css('width','215px');
				$('#chkXshowprice span').css('width','175px');
				
				/*if (q_getPara('sys.project').toUpperCase()=='FE'){
					$('#btnUcf').hide();
				}
				
				$('#btnUcf').click(function() {
					q_box('ucf.aspx' + "?;;;;" + r_accy, '', "450px", "200px", $('#btnUcf').val());
				});*/
				
				if (q_getPara('sys.project').toUpperCase()=='YC' && r_rank<8){
					$('#Xshowprice').hide();
				}
				
				if (q_getPara('sys.project').toUpperCase()=='YC')
					q_gt('ucc',"where=^^noa= (select MAX(noa) from ucc where left(noa,1)<'S') ^^", 0, 0, 0, "maxpno", r_accy);
				
				$('#txtProduct2a').change(function() {
					if (q_getPara('sys.project').toUpperCase()=='YC' && $('#txtProduct2a').val().substr(0,1).toUpperCase()>'S'){
						$('#txtProduct2a').val(maxpno);
						$('#txtProduct2b').val(maxproduct);
					}
				});
				
				$('#btnOk').focusin(function() {
					if (q_getPara('sys.project').toUpperCase()=='YC' && ($('#txtProduct2a').val().substr(0,1).toUpperCase()>'S' || emp($('#txtProduct2a').val()))){
						$('#txtProduct2a').val(maxpno);
						$('#txtProduct2b').val(maxproduct);
					}
				});
			}
			
			function q_popPost(s1) {
				switch (s1) {
					case 'txtProduct2a':
						if (q_getPara('sys.project').toUpperCase()=='YC' && $('#txtProduct2a').val().substr(0,1).toUpperCase()>'S'){
							$('#txtProduct2a').val(maxpno);
							$('#txtProduct2b').val(maxproduct);
						}
					break;
				}
			}

			function q_boxClose(s2) {
			}
			
			var maxpno='',maxproduct='';
			function q_gtPost(t_name) {
				switch (t_name) {
					case 'maxpno':
						var as = _q_appendData("ucc", "", true);
						if (as[0] != undefined) {
							maxpno=as[0].noa;
							maxproduct=as[0].product;
						}else{
							maxpno='SZZZZZZ'
							maxproduct='';
						}
						break;
					default:
						break;
				}
			}
		</script>
		<style type="text/css">
			/*.q_report .option {
			 width: 600px;
			 }
			 .q_report .option div.a1 {
			 width: 580px;
			 }
			 .q_report .option div.a2 {
			 width: 220px;
			 }
			 .q_report .option div .label {
			 font-size:medium;
			 }
			 .q_report .option div .text {
			 font-size:medium;
			 }
			 .q_report .option div .cmb{
			 height: 22px;
			 font-size:medium;
			 }
			 .q_report .option div .c2 {
			 width: 80px;
			 }
			 .q_report .option div .c3 {
			 width: 110px;
			 }*/
		</style>
	</head>
	<body id="z_accc" ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
		<div id="q_menu"> </div>
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;width:2000px;">
			<div id="container">
				<div id="q_report"> </div>
				<!--<input type="button" id="btnUcf" value="成本結轉" style="font-weight: bold;font-size: medium;color: red;">-->
			</div>
			<div class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>