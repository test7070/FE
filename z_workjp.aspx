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
            $(document).ready(function() {
            	q_getId();
                q_gf('', 'z_workjp');       
            });
            function getLocation(){
            	var parser = document.createElement('a');
				parser.href = document.URL;
				return parser.protocol+'//'+parser.host;
				/*
				parser.href = "http://example.com:3000/pathname/?search=test#hash";
				parser.protocol; // => "http:"
				parser.host;     // => "example.com:3000"
				parser.hostname; // => "example.com"
				parser.port;     // => "3000"
				parser.pathname; // => "/pathname/"
				parser.hash;     // => "#hash"
				parser.search;   // => "?search=test"*/			
            }
            function q_gfPost() {
				$('#q_report').q_report({
					fileName : 'z_workjp',
					options : [{
						type : '0', //[1]
						name : 'path',
						value : getLocation()
					},{
						type : '6', //[1]
						name : 'noa'
					},{
						type : '1', //[2][3]
						name : 'xdate'
					},{
						type : '1', //[4][5]
						name : 'xodate'
					},{
						type : '2', //[6][7]
						name : 'cust',
						dbf : 'cust',
						index : 'noa,comp,nick',
						src : 'cust_b.aspx'
					}]
				});
				q_popAssign();
                	
				$('#txtXdate1').mask('999/99/99');
				$('#txtXdate1').datepicker();
				$('#txtXdate2').mask('999/99/99');
				$('#txtXdate2').datepicker(); 
				$('#txtXodate1').mask('999/99/99');
				$('#txtXodate1').datepicker();
				$('#txtXodate2').mask('999/99/99');
				$('#txtXodate2').datepicker();  
	              
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
	            	$('#txtNoa').val(t_para.noa);
	            }
                $('#btnOk').hide();
        		$('#btnOk2').click(function(e){
        			switch($('#q_report').data('info').radioIndex) {
                        case 0:
                        	//預設事務機
        					//$('#cmbPcPrinter').val('NT33__SHARP MX-M283N PCL6');
                            $('#btnOk').click();
                            break;
                        case 1:
                            //EXCEL
                            q_func( 'barfe.genBmp1', $('#txtNoa').val());	
               				$('#btnOk2').val('圖片產生中，請稍後...').width(100).attr('disabled','disabled');
                            break;
                    }
        		});
            }

			function q_funcPost(t_func, result) {
                switch(t_func) {
                	case 'barfe.genBmp1':
                		$('#btnOk2').val('查詢').width(50).removeAttr('disabled');
                		$('#btnOk').click();
                		break;
                    default:
                        break;
                }
            }
			//function q_boxClose(s2) {}
			function q_gtPost(s2) {}
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
				<input type="button" id="btnOk2" style="float:left;font-size:16px;font-weight: bold;color: blue;cursor: pointer;width:50px;height:30px;" value="查詢"/>
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>
           
          