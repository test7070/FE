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
            var t_acomp = '';
            $(document).ready(function() {
            	q_getId();
            	q_gt('acomp', '', 0, 0, 0, "");
            });
            function q_gtPost(t_name) {
                switch (t_name) {
                    case 'acomp':
                        var as = _q_appendData("acomp", "", true);
                        t_acomp = " @全部";
                        for ( i = 0; i < as.length; i++) {
                            t_acomp = t_acomp + (t_acomp.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].acomp;
                        }
                        q_gf('', 'z_vcc2fep');
                        break;
                }
            }
            function q_gfPost() {
				$('#q_report').q_report({
					fileName : 'z_vcc2fep',
					options : [{
                        type : '0', //[1]
                        name : 'xname',
                        value : r_name 
                    },{
						type : '6', //[2]        1
						name : 'xnoa'
					},{
						type : '8', //[3]        2
						name : 'showprice',
						value : "1@顯示單價".split(',')
					},{
						type : '5', //[4]         3
						name : 'xcno',
						value : t_acomp.split(',')
					}, {
						type : '2', //[5][6]       4
						name : 'xcust',
						dbf : 'cust',
						index : 'noa,comp,nick',
						src : 'cust_b.aspx'
					}, {
						type : '1', //[7][8]       5
						name : 'xmon'
					}, {
						type : '6', //[9]        6
						name : 'edate'
					}]
				});
				q_popAssign();
				q_langShow();
            	
            	$('#txtXmon1').mask('999/99');
				$('#txtXmon2').mask('999/99');
				$('#txtXdate1').mask('999/99/99');
				$('#txtXdate1').datepicker();
				$('#txtXdate2').mask('999/99/99');
				$('#txtXdate2').datepicker();  
				
				$('#chkShowprice input').prop('checked',false);
	              
	            var t_para = new Array();
	            try{
	            	t_para = JSON.parse(q_getId()[3]);
	            }catch(e){
	            }    
	            if(t_para.length==0 || t_para.noa==undefined){
	            	var t_date,t_year,t_month,t_day;
	                t_date = new Date();
	                t_date.setDate(1);
	                t_year = t_date.getUTCFullYear()-1911;
	                t_year = t_year>99?t_year+'':'0'+t_year;
	                t_month = t_date.getUTCMonth()+1;
	                t_month = t_month>9?t_month+'':'0'+t_month;
	                t_day = t_date.getUTCDate();
	                t_day = t_day>9?t_day+'':'0'+t_day;
	                $('#txtXdate1').val(t_year+'/'+t_month+'/'+t_day);
		                
	                t_date = new Date();
	                t_date.setDate(35);
	                t_date.setDate(0);
	                t_year = t_date.getUTCFullYear()-1911;
	                t_year = t_year>99?t_year+'':'0'+t_year;
	                t_month = t_date.getUTCMonth()+1;
	                t_month = t_month>9?t_month+'':'0'+t_month;
	                t_day = t_date.getUTCDate();
	                t_day = t_day>9?t_day+'':'0'+t_day;
	                $('#txtXdate2').val(t_year+'/'+t_month+'/'+t_day);
	            }else{
	            	$('#txtXnoa').val(t_para.noa);
	            	$('#txtYnoa1').val(t_para.noa);
	            	$('#txtYnoa2').val(t_para.noa);
	            }
                
            }

			function q_boxClose(s2) {
            	
			}
     
		</script>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
		<div id="q_menu"> </div>
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;width:2000px;">
			<div id="container">
				<div id="q_report"> </div>
			</div>
			<div class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>
           
          