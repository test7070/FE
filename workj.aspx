<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">
			var __curData = null;
            $(function () {
		        var Sys = {};
		        var ua = navigator.userAgent.toLowerCase();
		        var s;
		        (s = ua.match(/rv:([\d.]+)\) like gecko/)) ? Sys.ie = s[1] :
		        (s = ua.match(/msie ([\d.]+)/)) ? Sys.ie = s[1] :
		        (s = ua.match(/firefox\/([\d.]+)/)) ? Sys.firefox = s[1] :
		        (s = ua.match(/chrome\/([\d.]+)/)) ? Sys.chrome = s[1] :
		        (s = ua.match(/opera.([\d.]+)/)) ? Sys.opera = s[1] :
		        (s = ua.match(/version\/([\d.]+).*safari/)) ? Sys.safari = s[1] : 0;
		        
		        if (!Sys.chrome)
		        	alert('請使用Chrome執行');
		        /*if (Sys.ie) document.write('IE: ' + Sys.ie);
		        if (Sys.firefox) document.write('Firefox: ' + Sys.firefox);
		        if (Sys.chrome) document.write('Chrome: ' + Sys.chrome);
		        if (Sys.opera) document.write('Opera: ' + Sys.opera);
		        if (Sys.safari) document.write('Safari: ' + Sys.safari);*/
		    });
		    
            q_tables = 't';
            var q_name = "workj";
            var q_readonly = ['txtNoa','txtOrdeno','txtMount','txtWeight','txtWorker','txtWorker2'];
            var q_readonlys = ['txtContno','txtContnoq','txtStore','txtMech','txtWeight','txtProduct'];
            var q_readonlyt = ['txtBno'];
            var bbmNum = [['txtMount',10,0,1],['txtWeight',10,2,1]];
            var bbsNum = [['txtMount',10,0,1],['txtWeight',10,2,1],['txtLengthb',10,0,1]];
            var bbtNum = [['txtGmount',10,2,1],['txtGweight',10,2,1],['txtMount',10,2,1],['txtWeight',10,2,1],['txtLengthb',10,0,1]];
            var bbmMask = [['txtOdate','999/99/99'],['txtDatea','999/99/99']];
            var bbsMask = [['txtTime1','99:99'],['txtTime2','99:99'],['txtTime3','99:99'],['txtTime4','99:99'],['txtTime5','99:99']];
            var bbtMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            q_desc = 1;
            brwCount2 = 6;
			q_bbsLen = 5;
            aPop = new Array(['txtProductno_', 'btnProduct_', 'ucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucc_b.aspx']
            	,['txtPicno_', 'btnPicno_', 'img', 'noa', 'txtPicno_', 'img_b.aspx']
            	,['txtProductno__', 'btnProduct__', 'ucc', 'noa,product', 'txtProductno__,txtProduct__', 'ucc_b.aspx']
            	,['txtUno__', 'btnUno__', 'view_uccc', 'uno,productno,product,spec,emount,eweight', 'txtUno__,txtProductno__,txtProduct__,,txtGmount__,txtGweight__', 'uccc_seek_b2.aspx?;;;1=0', '95%', '60%']
            	,['txtCustno', 'lblCust', 'cust', 'noa,comp,nick', 'txtCustno,txtCust,txtNick', 'cust_b.aspx']
            	,['txtStoreno__', 'btnStore__', 'store', 'noa,store', 'txtStoreno__,txtStore__', 'store_b.aspx']);
			
			var z_mech = '';
            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                bbtKey = ['noa', 'noq'];
                q_brwCount();
                q_gt('mech', "", 0, 0, 0, 'mech'); 
            });
			
            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(0);
            }

            function mainPost() {
                q_mask(bbmMask);
                q_cmbParse("cmbTagcolor", '桃紅色,紫色,天空藍,草綠色,黃色,膚色,白色');
                if(q_getPara('fe.trantype').length>0)
                	q_cmbParse("cmbTrantype", q_getPara('fe.trantype'));
                q_cmbParse("cmbTrantype1", ' ,板車-用倒的,板車-買方卸貨,板車+吊車,短板板車,板吊車,10.4噸吊車,15噸吊車,15噸貨車,3.5噸貨車');
                if(q_getPara('fe.trantype2').length>0)
                	q_cmbParse("cmbTrantype2",q_getPara('fe.trantype2'));
                if(z_mech.length>0){
                	q_cmbParse("cmbMech1", z_mech,'s');
	                q_cmbParse("cmbMech2", z_mech,'s');
	                q_cmbParse("cmbMech3", z_mech,'s');
	                q_cmbParse("cmbMech4", z_mech,'s');
	                q_cmbParse("cmbMech5", z_mech,'s');
                }
     
                $('#btnPrint_d').click(function(e){
                	$('#btnPrint_d').attr('disabled','disabled');
                	setTimeout(function(){$('#btnPrint_d').removeAttr('disabled');}, 3000);
                	Lock(1,{opacity:0});
                	var t_noq = '';
                	if($('#combPrint').val()=='barfe2-1.bat'){
                		var t_printCount = 0;
                		for(var i=0;i<q_bbtCount;i++){
	                		if($('#checkIsprint__'+i).prop('checked') && $.trim($('#txtBno__'+i).val()).length>0){
	                			t_noq += (t_noq.length>0?'^':'')+$('#txtNoq__'+i).val();	
	                			t_printCount ++;
	                		}            
	                	}        
	                	if(t_noq.length==0){
	                		alert('未選擇要列印的資料(餘料)。');
	                		Unlock(1);
	                	}else{
	                		if (confirm("已選擇 "+t_printCount+" 筆，是否列印條碼?") ) {
	                			q_func( 'barfe.gen2', $('#txtNoa').val()+',workjt,'+t_noq+','+$('#combPrint').val()); 
	                		}else{
	                			Unlock(1);
	                			return;
	                		}	                		
	                	}	
                	}else{
                		var t_printCount = 0;
                		var t_printPage = 0;
                		for(var i=0;i<q_bbsCount;i++){
	                		if($('#checkIsprint_'+i).prop('checked') && $.trim($('#txtProductno_'+i).val()).length>0){
	                			t_noq = t_noq + (t_noq.length>0?'^':'')+$('#txtNoq_'+i).val();	
	                			t_printCount ++;
	                			t_printPage += $('#txtCmount_'+i).val().split(',').length;
	                		}            
	                	}        
	                	if(t_noq.length==0){
	                		alert('未選擇要列印的資料(成品)。');
	                		Unlock(1);
                			return;
	                	}else{
	                		var vv = prompt("已選擇 "+t_printCount+" 筆共"+t_printPage+" 張條碼，請輸入列印範圍", "1-"+t_printPage);
							if (vv != null) {
								console.log($('#txtNoa').val()+',,'+t_noq+','+$('#combPrint').val()+','+vv.replace('-',','));
							    var patt = /^\d+\-\d+$/;
							    if(patt.test(vv))
							    	q_func( 'barfe.gen1', $('#txtNoa').val()+',,'+t_noq+','+$('#combPrint').val()+','+vv.replace('-',',')); 
								else{
									alert('列印範圍輸入錯誤!');
									Unlock(1);
	                				return;
								}
							}else{
	                			Unlock(1);
	                			return;
	                		}
	                		/*if (confirm("已選擇 "+t_printCount+" 筆共"+t_printPage+" 張條碼，是否列印?") ) {
	                			console.log(t_noq);
	                			q_func( 'barfe.gen1', $('#txtNoa').val()+',,'+t_noq+','+$('#combPrint').val()); 
	                		}else{
	                			Unlock(1);
	                			return;
	                		}*/
	                	}
                	}
                });
                $('#btnBarcode').click(function() {
                    $('#divImport').toggle();
                });
                $('#btnCancel_d').click(function() {
                    $('#divImport').toggle();
                });
                $('#btnChecker').click(function() {
                    $('#divChk').toggle();
                });
                $('#btnCancel_c').click(function() {
                    $('#divChk').toggle();
                    var t_noa = $('#txtNoa').val();
                    var t_checker = $('#textChecker').val();
                    q_func('qtxt.query.wkchecker', 'workj.txt,checker,' + encodeURI(t_noa)+ ';' +encodeURI(t_checker)); 
                });
                $('#textChecker').change(function() {
                	$('#txtChecker').val($(this).val());
               	});

                
                //-----------------------------------------------------------------------
                $('#btnCont').click(function(e){
                	var t_noa = $('#txtNoa').val();
                	var t_custno = $('#txtCustno').val();
                	//q_func('qtxt.query.cont', 'workj.txt,cont,' + encodeURI(t_noa) + ';' + encodeURI(t_custno)); 	
                	
                	var t_where ='';
                	q_box("contfe_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where+";"+";"+JSON.stringify({workjno:t_noa,custno:t_custno}), "cont_workj", "95%", "95%", '');
                });
                $('#btnOrde').click(function(e){
                	var t_key = q_getPara('sys.key_orde');
                	var t_noa = $('#txtNoa').val();
                	q_func('qtxt.query.orde', 'workj.txt,orde,' + encodeURI(t_key)+ ';' +encodeURI(t_noa)); 	
                });
                $('#lblOrdeno').click(function(e){
                	var t_noa= $('#txtOrdeno').val();
                	var t_accy = $('#txtOrdeaccy').val();
                	if(t_noa.length>0)
                		q_box("ordefe.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";noa='" + t_noa + "';" + t_accy, 'orde', "95%", "95%", q_getMsg("popOrde"));
                });
                $('#pageAll').parent().append('<input type="button" id="buttonCopy" value="複製"/>')
                .append('<input type="button" id="buttonPaste" value="貼上"/>');
                
                $('#buttonCopy').click(function(e){
                	var bbm={datea:$('#txtDatea').val()
                		,odate:$('#txtOdate').val()
                		,custno:$('#txtCustno').val()
                		,cust:$('#txtCust').val()
                		,nick:$('#txtNick').val()
                		,trantype:$('#cmbTrantype').val()
						,trantype1:$('#cmbTrantype1').val()
						,trantype2:$('#cmbTrantype2').val()
						,site:$('#txtSite').val()
						,tagcolor:$('#cmbTagcolor').val()
						,tolerance:$('#txtTolerance').val()
						,memo:$('#txtMemo').val() 
						,chktype:$('#txtChktype').val()
						,mount:$('#txtMount').val()
						,weight:$('#txtWeight').val()};
					
					var bbs = new Array();
					for(var i=0;i<q_bbsCount;i++){
						bbs.push({productno:$('#txtProductno_'+i).val()
							,product:$('#txtProduct_'+i).val()
							,memo:$('#txtMemo_'+i).val()
							,cmount:$('#txtCmount_'+i).val()
							,cweight:$('#txtCweight_'+i).val()
							,place:$('#txtPlace_'+i).val()
							,paraa:$('#txtParaa_'+i).val()
							,parab:$('#txtParab_'+i).val()
							,parac:$('#txtParac_'+i).val()
							,parad:$('#txtParad_'+i).val()
							,parae:$('#txtParae_'+i).val()
							,paraf:$('#txtParaf_'+i).val()
							,lengthb:$('#txtLengthb_'+i).val()
							,mount:$('#txtMount_'+i).val()
							,weight:$('#txtWeight_'+i).val()
							,mech1:$('#cmbMech1_'+i).val()
							,mech2:$('#cmbMech2_'+i).val()
							,mech3:$('#cmbMech3_'+i).val()
							,mech4:$('#cmbMech4_'+i).val()
							,place1:$('#txtPlace1_'+i).val()
							,place2:$('#txtPlace2_'+i).val()
							,place3:$('#txtPlace3_'+i).val()
							,place4:$('#txtPlace4_'+i).val()
							,place5:$('#txtPlace5_'+i).val()
							,time1:$('#txtTime1_'+i).val()
							,time2:$('#txtTime2_'+i).val()
							,time3:$('#txtTime3_'+i).val()
							,time4:$('#txtTime4_'+i).val()
							,time5:$('#txtTime5_'+i).val()
							,worker1:$('#txtWorker1_'+i).val()
							,worker2:$('#txtWorker2_'+i).val()
							,worker3:$('#txtWorker3_'+i).val()
							,worker4:$('#txtWorker4_'+i).val()
							,worker5:$('#txtWorker5_'+i).val()
							,picno:$('#txtPicno_'+i).val()
							,para:$('#txtPara_'+i).val()
							,imgorg:$('#txtImgorg_'+i).val()
							//,imgdata:$('#txtImgdata_'+i).val()
							//,imgbarcode:$('#txxtImgbarcode_'+i).val()
						});
					}
                	__curData = {bbm:bbm,bbs:bbs};
                });
                $('#buttonPaste').click(function(e){
                	if(__curData==null){
                		alert('未複製。');
                		return;
                	}
                	var bbm = __curData.bbm;
                	$('#txtDatea').val(bbm.datea);
                	$('#txtOdate').val(bbm.odate);
					$('#txtCustno').val(bbm.custno);
                	$('#txtCust').val(bbm.cust);
                	$('#txtNick').val(bbm.nick);
            		$('#cmbTrantype').val(bbm.trantype);
					$('#cmbTrantype1').val(bbm.trantype1);
					$('#cmbTrantype2').val(bbm.trantype2);
					$('#txtSite').val(bbm.site);
					$('#cmbTagcolor').val(bbm.tagcolor);
					$('#txtTolerance').val(bbm.tolerance);
					$('#txtMemo').val(bbm.memo);
					$('#txtChktype').val(bbm.chktype);
					$('#txtMount').val(bbm.mount);
					$('#txtWeight').val(bbm.weight);
                	
                	var bbs=__curData.bbs;
                	while(q_bbsCount<bbs.length){
                		$('#btnPlus').click();
                	}
                	for(var i=0;i<q_bbsCount;i++){
                		$('#btnMinus__'+i).click();
                		if(i>=bbs.length)
                			continue;
                		$('#txtProductno_'+i).val(bbs[i].productno);
						$('#txtProduct_'+i).val(bbs[i].product);
						$('#txtMemo_'+i).val(bbs[i].memo);
						$('#txtCmount_'+i).val(bbs[i].cmount);
						$('#txtCweight_'+i).val(bbs[i].cweight);
						$('#txtPlace_'+i).val(bbs[i].place);
						$('#txtParaa_'+i).val(bbs[i].paraa);
						$('#txtParab_'+i).val(bbs[i].parab);
						$('#txtParac_'+i).val(bbs[i].parac);
						$('#txtParad_'+i).val(bbs[i].parad);
						$('#txtParae_'+i).val(bbs[i].parae);
						$('#txtParaf_'+i).val(bbs[i].paraf);
						$('#txtLengthb_'+i).val(bbs[i].lengthb);
						$('#txtMount_'+i).val(bbs[i].mount);
						$('#txtWeight_'+i).val(bbs[i].weight);
						$('#cmbMech1_'+i).val(bbs[i].mech1);
						$('#cmbMech2_'+i).val(bbs[i].mech2);
						$('#cmbMech3_'+i).val(bbs[i].mech3);
						$('#cmbMech4_'+i).val(bbs[i].mech4);
						$('#txtPlace1_'+i).val(bbs[i].place1);
						$('#txtPlace2_'+i).val(bbs[i].place2);
						$('#txtPlace3_'+i).val(bbs[i].place3);
						$('#txtPlace4_'+i).val(bbs[i].place4);
						$('#txtPlace5_'+i).val(bbs[i].place5);
						$('#txtTime1_'+i).val(bbs[i].time1);
						$('#txtTime2_'+i).val(bbs[i].time2);
						$('#txtTime3_'+i).val(bbs[i].time3);
						$('#txtTime4_'+i).val(bbs[i].time4);
						$('#txtTime5_'+i).val(bbs[i].time5);
						$('#txtWorker1_'+i).val(bbs[i].worker1);
						$('#txtWorker2_'+i).val(bbs[i].worker2);
						$('#txtWorker3_'+i).val(bbs[i].worker3);
						$('#txtWorker4_'+i).val(bbs[i].worker4);
						$('#txtWorker5_'+i).val(bbs[i].worker5);
						$('#txtPicno_'+i).val(bbs[i].picno);
						$('#txtPara_'+i).val(bbs[i].para);
						$('#txtImgorg_'+i).val(bbs[i].imgorg);
						//$('#txtImgdata_'+i).val(bbs[i].imgdata);
						//$('#txtImgbarcode_'+i).val(bbs[i].imgbarcode);
						createImg(i);//產生圖片 ,若太多筆要等一下
                	}
                
                });
            }
            function checkAll(){
            	$('.justPrint').prop('checked',$('.checkAll').prop('checked'));
            }
            function checkAll2(){
            	$('.justPrint2').prop('checked',$('.checkAll2').prop('checked'));
            }
            function q_funcPost(t_func, result) {
                switch(t_func) {
                	case 'barfe.gen1':
                		Unlock(1);
                		break;
                	case 'barfe.gen2':
                		Unlock(1);
                		break;
                	case 'qtxt.query.wkchecker':
                		alert('已修改!'); 
                		break;
                	case 'qtxt.query.cont':
                		var as = _q_appendData("tmp0", "", true, true);
                        if (as[0] != undefined) {
                            q_gridAddRow(bbsHtm, 'tbbs', 'txtContno,txtContnoq,txtProductno,txtProduct,txtLengthb,txtMount,txtWeight'
                        	, as.length, as, 'contno,contnoq,productno,product,lengthb,xmount,xweight', '','');
                        	sum();
                        } else {
                            alert('無資料!');
                        }
                		break;
            		case 'qtxt.query.orde':
                		var as = _q_appendData("tmp0", "", true, true);
                        if (as[0] != undefined) {
                        	if(as[0].ordeno != undefined && as[0].ordeno.length>0){
                        		$('#txtOrdeno').val(as[0].ordeno);
                        		$('#txtOrdeaccy').val(as[0].ordeaccy);
                        		abbm[q_recno].ordeno = as[0].ordeno;
                        		abbm[q_recno].ordeaccy = as[0].ordeaccy;
                        	}else{
                        		alert(as[0].msg);
                        	}
                        } else {
                            alert('匯出訂單錯誤!');
                        }
                        Unlock(1);
                        //取得餘料編號
                        q_gt('workj', "where=^^noa='"+$('#txtNoa').val()+"'^^", 0, 0, 0, 'getBno'); 
                		break;
                    default:
                        break;
                }
            }
			function q_popPost(id) {
                switch (id) {
                	case 'txtProductno_':
                		var n = b_seq;
                		//createImg(n);
                		break;
                	case 'txtPicno_':
                		var n = b_seq;
                		t_noa = $('#txtPicno_'+n).val();
                		q_gt('img', "where=^^noa='"+t_noa+"'^^", 0, 0, 0, JSON.stringify({action:"getimg",n:n}),1);
                   		break;
                    default:
                        break;
                }
            }
            function q_gtPost(t_name) {
                switch (t_name) {
                	case 'acomp':
  						var as = _q_appendData("acomp", "", true);
                		if (r_rank<'8' && q_getPara('sys.project').toUpperCase()=='FE' && (r_userno.substr(0,1).toUpperCase())=='B'){
  							q_content = "where=^^exists (select * from cust where noa=workj.custno and salesno='" + r_userno + "')^^";
  							q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
  		
  						}else{
  							if(q_content.length>0){
	                        	q_content = replaceAll(q_content,'where=^^','');
	                        }else{
	                        	q_content = "";
	                        }
  							q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
  						}
                		break;
                		
                	case 'getBno':
                		var as = _q_appendData("workjt", "", true);
                		if (as[0] != undefined) {
                			//q_bbtCount
                			t_noa = $('#txtNoa').val();
							for(var i=0;i<q_bbtCount.length;i++){
								if($('#txtBno__'+i).val().length == 0){
									t_noq = $('#txtNoq__'+i).val();
									for(var j=0;j<as.length;j++){
										if(as[j].noa==t_noa && as[j].noq==t_noq){
											$('#txtBno__'+i).val(as[j].bno);
											break;
										}
									}
								}
							}    
							//abbt       
							for(var i=0;i<abbt.length;i++){
								if(abbt[i].bno.length == 0){
									t_noa = abbt[i].noa;
									t_noq = abbt[i].noq;
									for(var j=0;j<as.length;j++){
										if(as[j].noa==t_noa && as[j].noq==t_noq){
											abbt[i].bno = as[j].bno;
											break;
										}
									}
								}
							}      			
                		}
                		Unlock(1);
                		break;
                	case 'mech':
                		var as = _q_appendData("mech", "", true);
                		if (as[0] != undefined) {
                			z_mech = ' @';
	                		for(var i=0;i<as.length;i++){
	                			z_mech += (z_mech.length>0?',':'')+as[i].noa+'@'+as[i].mech;
	                		}
                		}
                		q_gt('acomp', 'where=^^1=1^^', 0, 1);
                		break;
                	case 'btnModi':
                		var as = _q_appendData("view_vccs", "", true);
                        if (as[0] != undefined) {
                        	alert('已訂單已出貨，禁止修改。');
                        }else{
                        	_btnModi();
                			$('#txtDatea').focus();
                        }
                        Unlock(1);
                		break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                    default:
                    	try{
                    		var t_para = JSON.parse(t_name);
                    		if(t_para.action=="getimg"){
                    			var n = t_para.n;
                    			as = _q_appendData("img", "", true);
                    			if(as[0]!=undefined){
                    				$('#txtPara_'+n).val(as[0].para);
                    			}else{
                    				$('#txtPara_'+n).val('');
                    			}
                    			createImg(n);
                    		}else if(t_para.action=="createimg" || t_para.action=="createimg_btnOk"){
                    			alert('xxxx');
							}
                    	}catch(e){
                    		Unlock(1);
                    	}
                        break;
                }
            }
            
			function createImg(n){
				var t_para = $('#txtPara_'+n).val();
				try{
					t_para = JSON.parse(t_para);
				}catch(e){
					console.log('createImg:'+t_para);
				}
				var t_length = 0;
				for(var i=0;i<t_para.length;i++){
					value = q_float('txtPara'+t_para[i].key.toLowerCase()+'_'+n);
					if(value!=0){
						t_length += value;
					}
				}
				//------------------------------
				if($('#txtMemo_'+n).val().substring(0,1)!='*'){
					$('#txtLengthb_'+n).val(t_length);
				}
				refreshImg(n,true);
			};
			
            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                Lock(1,{opacity:0.5});
                saveImg(q_bbsCount-1);
            }

            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                	case 'cont_workj':
                        if (b_ret != null) {
                        	as = b_ret;
                    		q_gridAddRow(bbsHtm, 'tbbs', 'txtContno,txtContnoq,txtProductno,txtProduct,txtLengthb,txtMount,txtWeight'
                        	, as.length, as, 'contno,contnoq,productno,product,lengthb,mount,weight', '','');
                        }else{
                        	Unlock(1);
                        }
                        break;
                    case q_name + '_s':
                        q_boxClose2(s2);
                        break;
                }
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)
                    return;
                q_box('workj_s.aspx', q_name + '_s', "550px", "440px", q_getMsg("popSeek"));
            }

            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtDatea').val(q_date());
                $('#txtOdate').val(q_date());
                $('#txtDatea').focus();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                var t_ordeno = $('#txtOrdeno').val();
                if(t_ordeno.length>0){
                	Lock(1,{opacity:0});
               		q_gt('view_vccs', "where=^^ ordeno='"+t_ordeno+"' ^^ stop=1", 0, 0, 0, 'btnModi'); 
                }
                else{
                	_btnModi();
                	$('#txtDatea').focus();
                }    
            }

            function btnPrint() {
                q_box("z_workjp.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + JSON.stringify({noa:trim($('#txtNoa').val())}) + ";" + r_accy + "_" + r_cno, 'workj', "95%", "95%", m_print);
            }

            function btnOk() {
            	//backupData();
                Lock(1, {
                    opacity : 0
                });
                $('#bbsXpand').click();
                if ($('#txtDatea').val().length == 0 || !q_cd($('#txtDatea').val())) {
                    alert(q_getMsg('lblDatea') + '錯誤。');
                    Unlock(1);
                    return;
                }
                if($.trim($('#txtCustno').val()).length==0){
                	alert(q_getMsg('lblCust') + '空白。');
                    Unlock(1);
                    return;
                }
                if ($('#txtDatea').val()>$('#txtOdate').val()) {
                    alert(q_getMsg('lblDatea') + '須小於等於' + q_getMsg('lblOdate'));
                    Unlock(1);
                    return;
                }
                var patt =/^\-{0,1}\d*\.{0,1}\d*$/;
                for(var i=0;i<q_bbsCount;i++){
                	if(!patt.test($('#txtParaa_'+i).val()))
                		$('#txtParaa_'+i).val('0');
                	if(!patt.test($('#txtParab_'+i).val()))
                		$('#txtParab_'+i).val('0');
            		if(!patt.test($('#txtParac_'+i).val()))
                		$('#txtParac_'+i).val('0');
            		if(!patt.test($('#txtParad_'+i).val()))
                		$('#txtParad_'+i).val('0');
            		if(!patt.test($('#txtParae_'+i).val()))
                		$('#txtParae_'+i).val('0');
            		if(!patt.test($('#txtParaf_'+i).val()))
                		$('#txtParaf_'+i).val('0');	
                }
                
                for(var i=0;i<q_bbtCount;i++){
                	t_uno = $.trim($('#txtUno__'+i).val());
                	t_lengthb = parseInt(round(q_float('txtLengthb__'+i)/10,0)*10);
                	t_weight = q_float('txtWeight__'+i);
                	t_mount = q_float('txtMount__'+i);
                	if(t_uno.length>0 && t_lengthb>0){
                		t_bno = '0000'+t_lengthb;
                		t_bno = t_uno +'-' + t_bno.substring(t_bno.length-4,t_bno.length);
                		$('#txtBno__'+i).val(t_bno);
                	}
                }
                
                var key = ['a','b','c','d','e','f'];
                var n = 0;
                for(var i=0;i<q_bbsCount;i++){
                	n=0;
                	for(var j=0;j<key.length;j++){
                		n += parseFloat($('#txtPara'+key[j]+'_'+i).val())>=240?1:0;
                		if(n>=2){
                			alert('加工品項有兩個參數(含兩個)，超過240cm。');
                			break;
                		}
                	}
                	if(n>=2)
            			break;
                }
                
                if (q_cur == 1) {
                    $('#txtWorker').val(r_name);
                } else
                    $('#txtWorker2').val(r_name);
                sum();
                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_workj') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
            }

            function wrServer(key_value) {
                var i;
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (!as['product'] && !as['para']) {
                    as[bbsKey[1]] = '';
                    return;
                }
                q_nowf();
                return true;
            }

            function refresh(recno) {
                _refresh(recno);
                $('.justPrint').prop('checked',true);	
                $('.justPrint2').prop('checked',true);	
                $('.checkAll').prop('checked',true);	
                $('.checkAll2').prop('checked',true);
                
                for(var i=0;i<q_bbsCount;i++){
                	refreshImg(i,false);
                }
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                if (t_para) {
                    $('#txtDatea').datepicker('destroy');
                    $('#txtOdate').datepicker('destroy');
                    $('.justPrint').removeAttr('disabled');
                    $('.justPrint2').removeAttr('disabled');
                    $('.checkAll').removeAttr('disabled');
                    $('.checkAll2').removeAttr('disabled');
                    
                    $('#buttonCopy').removeAttr('disabled');
                    $('#buttonPaste').attr('disabled','disabled');
                } else {	
                    $('#txtDatea').datepicker();
                    $('#txtOdate').datepicker();
                    $('.justPrint').attr('disabled','disabled');
                    $('.justPrint2').attr('disabled','disabled');
                    $('.checkAll').attr('disabled','disabled');
                    $('.checkAll2').attr('disabled','disabled');
                    
                    $('#buttonCopy').attr('disabled','disabled');
                    $('#buttonPaste').removeAttr('disabled');
                }
                
                if(q_cur==1 || q_cur==2){
                	$('#btnOrde').attr('disabled','disabled');
                	$('#btnPrint_d').attr('disabled','disabled');
                	$('#btnCont').removeAttr('disabled');
                }else{
                	$('#btnCont').attr('disabled','disabled');
                	$('#btnOrde').removeAttr('disabled');
                	$('#btnPrint_d').removeAttr('disabled');
                }
            }

            function btnMinus(id) {
                _btnMinus(id);
            }
            function btnPlus(org_htm, dest_tag, afield) {
                _btnPlus(org_htm, dest_tag, afield);
            }
            /*function btnPlut(org_htm, dest_tag, afield) {
                _btnPlut(org_htm, dest_tag, afield);
            }*/
			
			function CopyMech(n){
				if(!$('#lbl_mech').data('isInit')){
					$('#lbl_mech').bind('contextmenu', function(e) {
	                    /*滑鼠右鍵*/
	                    e.preventDefault();
	                    $('#lbl_mech').data('isInit',true);
	                    //假如已有複製標記就清除
	                    if($('#lbl_mech').data('copy')==null || $('#lbl_mech').data('copy').length==0){
	                    }else{
	                    	$('#lbl_mech').data('copy','').css('color','white');
	                    }
	                });
				}
				if($('#lbl_mech').data('copy') == null || $('#lbl_mech').data('copy').length==0){
                	$('#lbl_mech').data('copy',n).css('color','red');
                }else{
                	var targetN = $('#lbl_mech').data('copy');
                	$('#cmbMech1_'+n).val($('#cmbMech1_'+targetN).val());
                	$('#cmbMech2_'+n).val($('#cmbMech2_'+targetN).val());
                	$('#cmbMech3_'+n).val($('#cmbMech3_'+targetN).val());
                	$('#cmbMech4_'+n).val($('#cmbMech4_'+targetN).val());
                	$('#cmbMech5_'+n).val($('#cmbMech5_'+targetN).val());
                }
			}
            function bbsAssign() {
                for (var i = 0; i < q_bbsCount; i++) {
                    $('#lblNo_' + i).text(i + 1);
                    $('#imgPic_'+ i).attr('src','..\\htm\\htm\\img\\workj' + $('#txtNoa').val()+'-'+$('#txtNoq_'+ i).val()+'.png?'+(new Date().Format("yyyy-MM-dd hh:mm:ss")));
                    
                    if (!$('#btnMinus_' + i).hasClass('isAssign')) {
                    	//機台複製
                    	$('#cmbMech1_' + i).bind('contextmenu', function(e) {
                            /*滑鼠右鍵*/
                            e.preventDefault();
                            var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                            CopyMech(n);
                        });
                        $('#cmbMech2_' + i).bind('contextmenu', function(e) {
                            /*滑鼠右鍵*/
                            e.preventDefault();
                            var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                            CopyMech(n);
                        });
                        $('#cmbMech3_' + i).bind('contextmenu', function(e) {
                            /*滑鼠右鍵*/
                            e.preventDefault();
                            var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                            CopyMech(n);
                        });
                        $('#cmbMech4_' + i).bind('contextmenu', function(e) {
                            /*滑鼠右鍵*/
                            e.preventDefault();
                            var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                            CopyMech(n);
                        });
                        $('#cmbMech5_' + i).bind('contextmenu', function(e) {
                            /*滑鼠右鍵*/
                            e.preventDefault();
                            var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                            CopyMech(n);
                        });
                    	//--------------------------------------------------------------
                    	$('#txtProductno_' + i).bind('contextmenu', function(e) {
                            /*滑鼠右鍵*/
                            e.preventDefault();
                            var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                            $('#btnProduct_'+n).click();
                        });
                        $('#txtStoreno_' + i).bind('contextmenu', function(e) {
                            /*滑鼠右鍵*/
                            e.preventDefault();
                            var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                            $('#btnStore_'+n).click();
                        });
                        $('#txtPicno_' + i).bind('contextmenu', function(e) {
                            /*滑鼠右鍵*/
                            e.preventDefault();
                            var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                            $('#btnPicno_'+n).click();
                        });
                    	$('#txtParaa_'+i).change(function(e){
                    		var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                    		$(this).val(isNaN(q_float($(this).attr('id')))?0:q_float($(this).attr('id')));
                    		createImg(n);
                    	});
                    	$('#txtParab_'+i).change(function(e){
                    		var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                    		$(this).val(isNaN(q_float($(this).attr('id')))?0:q_float($(this).attr('id')));
                    		createImg(n);
                    	});
                    	$('#txtParac_'+i).change(function(e){
                    		var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                    		$(this).val(isNaN(q_float($(this).attr('id')))?0:q_float($(this).attr('id')));
                    		createImg(n);
                    	});
                    	$('#txtParad_'+i).change(function(e){
                    		var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                    		$(this).val(isNaN(q_float($(this).attr('id')))?0:q_float($(this).attr('id')));
                    		createImg(n);
                    	});
                    	$('#txtParae_'+i).change(function(e){
                    		var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                    		$(this).val(isNaN(q_float($(this).attr('id')))?0:q_float($(this).attr('id')));
                    		createImg(n);
                    	});
                    	$('#txtParaf_'+i).change(function(e){
                    		var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                    		$(this).val(isNaN(q_float($(this).attr('id')))?0:q_float($(this).attr('id')));
                    		createImg(n);
                    	});
                    	$('#txtContno_' + i).bind('contextmenu', function(e) {
                            /*滑鼠右鍵*/
                            e.preventDefault();
                            var t_noa =  $(this).val();
                            if(t_noa.length>0)
                            	q_box("contfe.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";noa='" + t_noa + "';" + r_accy, 'cont', "95%", "95%", q_getMsg("popCont"));
                        });
                        $('#txtProduct_'+i).change(function(e){
                        	sum();
                        });
                        $('#txtLengthb_'+i).change(function(e){
                    		sum();
                    	});
                    	$('#txtMount_'+i).change(function(e){
                    		sum();
                    	});
                    }
                }
                _bbsAssign();
            }

            function bbtAssign() {
                for (var i = 0; i < q_bbtCount; i++) {
                    $('#lblNo__' + i).text(i + 1);
                    if (!$('#btnMinut__' + i).hasClass('isAssign')) {
                    	$('#txtProductno__' + i).bind('contextmenu', function(e) {
                            /*滑鼠右鍵*/
                            e.preventDefault();
                            var n = $(this).attr('id').replace('txtProductno__', '');
                            $('#btnProduct__'+n).click();
                        });
                        $('#txtStoreno__' + i).bind('contextmenu', function(e) {
                            /*滑鼠右鍵*/
                            e.preventDefault();
                            var n = $(this).attr('id').replace('txtStoreno__', '');
                            $('#btnStore__'+n).click();
                        });
                        $('#txtUno__' + i).bind('contextmenu', function(e) {
                            /*滑鼠右鍵*/
                            e.preventDefault();
                            var n = $(this).attr('id').replace('txtUno__', '');
                            $('#btnUno__'+n).click();
                        });
                    }
                }
                _bbtAssign();
            }

            function sum() {
                if (!(q_cur == 1 || q_cur == 2))
                    return;
                for(var i=0;i<q_bbsCount;i++){
                	//檢查參數輸入是否有問題
                	$('#txtParaa_'+i).val(isNaN(q_float('txtParaa_'+i))?0:q_float('txtParaa_'+i));
                	$('#txtParab_'+i).val(isNaN(q_float('txtParab_'+i))?0:q_float('txtParab_'+i));
                	$('#txtParac_'+i).val(isNaN(q_float('txtParac_'+i))?0:q_float('txtParac_'+i));
                	$('#txtParad_'+i).val(isNaN(q_float('txtParad_'+i))?0:q_float('txtParad_'+i));
                	$('#txtParae_'+i).val(isNaN(q_float('txtParae_'+i))?0:q_float('txtParae_'+i));
                	$('#txtParaf_'+i).val(isNaN(q_float('txtParaf_'+i))?0:q_float('txtParaf_'+i));
                }
                var calc =[{key:'3#',value:0.56,m300:400,m600:400,m1000:270,m1600:250,w300:600,w600:1300,w1000:1300,w1600:1300}
	                ,{key:'4#',value:0.994,m300:300,m600:250,m1000:150,m1600:130,w300:500,w600:1300,w1000:1300,w1600:1300}
	                ,{key:'5#',value:1.56,m300:200,m600:160,m1000:100,m1600:80,w300:900,w600:1300,w1000:1300,w1600:1300}
	                ,{key:'6#',value:2.25,m300:160,m600:120,m1000:70,m1600:55,w300:1000,w600:1500,w1000:1500,w1600:1500}
	                ,{key:'7#',value:3.05,m300:150,m600:80,m1000:50,m1600:40,w300:1300,w600:1500,w1000:1500,w1600:1500}
	                ,{key:'8#',value:3.98,m300:130,m600:60,m1000:40,m1600:30,w300:1500,w600:1500,w1000:1500,w1600:1500}
	                ,{key:'9#',value:5.08,m300:100,m600:50,m1000:30,m1600:20,w300:1500,w600:1500,w1000:1500,w1600:1500}
	                ,{key:'10#',value:6.39,m300:80,m600:40,m1000:25,m1600:20,w300:1500,w600:1500,w1000:1500,w1600:1500}
	                ,{key:'11#',value:7.9,m300:70,m600:30,m1000:20,m1600:15,w300:1500,w600:1500,w1000:1500,w1600:1500}];
	             
	            var t_weight=0,t_mount=0,t_weights;
                for(var i=0;i<q_bbsCount;i++){
                	t_length = q_float('txtLengthb_'+i);
                	t_weights = 0;
                	t_mounts = q_float('txtMount_'+i);  	
                	t_product = $('#txtProduct_'+i).val();
                	//分批
               		t_cmount = '';
               		t_cweight = '';
               		t_n = 0;
               		t_m = 0;
                	if(t_product.length>0){
                		for(var j=0;j<calc.length;j++){
							if(t_product.indexOf(calc[j].key)>0){
								t_weights = round(q_mul(q_mul(calc[j].value,t_length/100),t_mounts),2);
								//單一隻的重
								t_w = q_mul(calc[j].value,t_length/100);
								t_mm = 0;
								if(t_length<=300){
									//限重內最大支數
									t_mm = t_w==0?0:Math.floor(q_div(calc[j].w300,t_w));
									t_mm = Math.max(calc[j].m300,t_mm);
								}else if(t_length<=600){
									//限重內最大支數
									t_mm = t_w==0?0:Math.floor(q_div(calc[j].w600,t_w));
									t_mm = Math.max(calc[j].m600,t_mm);
								}else if(t_length<=1000){
									//限重內最大支數
									t_mm = t_w==0?0:Math.floor(q_div(calc[j].w1000,t_w));
									t_mm = Math.max(calc[j].m1000,t_mm);
								}else{//1600
									//限重內最大支數
									t_mm = t_w==0?0:Math.floor(q_div(calc[j].w1600,t_w));
									t_mm = Math.max(calc[j].m1600,t_mm);
								}
								if(t_mounts<=t_mm || t_mm==0){
									//不須分批
									t_cmount = t_mounts;
									t_cweight = t_weights;
								}else{
									t_n = Math.floor(t_mounts/t_mm);
									t_m = t_mounts%t_mm;
									for(var k=0;k<t_n;k++){
										t_cmount += (t_cmount.length>0?',':'')+t_mm;
										t_cweight += (t_cweight.length>0?',':'') + round(q_mul(q_mul(calc[j].value,t_length/100),t_mm),0);
									}
									if(t_m>0){
										t_cmount += (t_cmount.length>0?',':'')+t_m;
										t_cweight += (t_cweight.length>0?',':'') + round(q_mul(q_mul(calc[j].value,t_length/100),t_m),0);
									}
								}	
								break;
							}                			
                		}
                	}              
                	//-----------------------------------
					$('#txtCmount_'+i).val(t_cmount);
					$('#txtCweight_'+i).val(t_cweight);
                	
                	$('#txtWeight_'+i).val(t_weights);
                	t_weight = q_add(t_weight,t_weights);
                	t_mount = q_add(t_mount,t_mounts);
                }
                $('#txtWeight').val(t_weight);
                $('#txtMount').val(t_mount);
            }

            function q_appendData(t_Table) {
                return _q_appendData(t_Table);
            }

            function btnSeek() {
                _btnSeek();
            }

            function btnTop() {
                _btnTop();
            }

            function btnPrev() {
                _btnPrev();
            }

            function btnPrevPage() {
                _btnPrevPage();
            }

            function btnNext() {
                _btnNext();
            }

            function btnNextPage() {
                _btnNextPage();
            }

            function btnBott() {
                _btnBott();
            }

            function q_brwAssign(s1) {
                _q_brwAssign(s1);
            }

            function btnDele() {
            	
                _btnDele();
            }

            function btnCancel() {
                _btnCancel();
            }

            function onPageError(error) {
                alert("An error occurred:\r\n" + error.Message);
            }
            //
            function refreshImg(n,status){
            	var t_picno = $.trim($('#txtPicno_'+n).val());
            	if(t_picno.length==0){
            		$('#imgPic_'+ n).attr('src','');
            		return;
            	}
            	
            	if(!status){
            		$('#imgPic_'+ n).attr('src','..\\htm\\htm\\img\\workj' + $('#txtNoa').val()+'-'+$('#txtNoq_'+ n).val()+'.png?'+(new Date().Format("yyyy-MM-dd hh:mm:ss")));
            		return;
            	}
            	
				var t_para =  JSON.stringify({A:$('#txtParaa_'+n).val()
					,B:$('#txtParab_'+n).val()
					,C:$('#txtParac_'+n).val()
					,D:$('#txtParad_'+n).val()
					,E:$('#txtParae_'+n).val()
					,F:$('#txtParaf_'+n).val()});
				$.ajax({
					n : n,
                    url: 'getImage_fe.aspx',
                    headers: { },
                    type: 'POST',
                    data: JSON.stringify({ db:q_db
                    	,action:"tmp",table:"workj"
                    	,originImg: '',picno:t_picno
                    	,orgpara:'',para:t_para}),
                    dataType: 'text',
                    timeout: 10000,
                    success: function(data){
                    	//回傳檔名
                    	var file = JSON.parse(data);
                    	$('#imgPic_'+this.n).attr('src','..\\htm\\htm\\tmp\\'+file.filename+'?'+(new Date().Format("yyyy-MM-dd hh:mm:ss")));
                    	if($('#txtMemo_'+n).val().substring(0,1)!='*'){
							$('#txtLengthb_'+n).val(file.lengthb);
						}
                    },
                    complete: function(){ 
                    },
                    error: function(jqXHR, exception) {
                    	$('#imgPic_'+this.n).attr('src','');
                        var errmsg = this.url+'資料寫入異常。\n';
                        if (jqXHR.status === 0) {
                            alert(errmsg+'Not connect.\n Verify Network.');
                        } else if (jqXHR.status == 404) {
                            alert(errmsg+'Requested page not found. [404]');
                        } else if (jqXHR.status == 500) {
                            alert(errmsg+'Internal Server Error [500].');
                        } else if (exception === 'parsererror') {
                            alert(errmsg+'Requested JSON parse failed.');
                        } else if (exception === 'timeout') {
                            alert(errmsg+'Time out error.');
                        } else if (exception === 'abort') {
                            alert(errmsg+'Ajax request aborted.');
                        } else {
                            alert(errmsg+'Uncaught Error.\n' + jqXHR.responseText);
                        }
                    }
                });
			}
			function saveImg(n){
            	if(n<0){
            		//匯出訂單
	                //餘料編號
	                $('#btnOrde').click();
            		return;
            	}
            	var t_picno = $.trim($('#txtPicno_'+n).val());
            	if(t_picno.length==0){
            		$('#imgPic_'+ n).attr('src','');
            		saveImg(n-1);
            		return;
            	}
				var t_para =  JSON.stringify({A:$('#txtParaa_'+n).val()
					,B:$('#txtParab_'+n).val()
					,C:$('#txtParac_'+n).val()
					,D:$('#txtParad_'+n).val()
					,E:$('#txtParae_'+n).val()
					,F:$('#txtParaf_'+n).val()});
				var t_noa = $.trim($('#txtNoa').val());
				var t_noq = $.trim($('#txtNoq_'+n).val());
				$.ajax({
					n : n,
					noa : t_noa,
					noq : t_noq,
                    url: 'getImage_fe.aspx',
                    headers: { },
                    type: 'POST',
                    data: JSON.stringify({ db:q_db
                    	,action:"img",table:"workj"
                    	,originImg: '',picno:t_picno
                    	,orgpara:'',para:t_para
                    	,noa:t_noa,noq:t_noq}),
                    dataType: 'text',
                    timeout: 10000,
                    success: function(data){
                    	//回傳檔名
                    	var file = JSON.parse(data);
                    	$('#imgPic_'+this.n).attr('src','..\\htm\\htm\\img\\workj'+this.noa+'-'+this.noq+'.png?'+(new Date().Format("yyyy-MM-dd hh:mm:ss")));
                    	if($('#txtMemo_'+n).val().substring(0,1)!='*'){
							$('#txtLengthb_'+n).val(file.lengthb);
						}
                    },
                    complete: function(){ 
                    	saveImg(this.n-1);
                    },
                    error: function(jqXHR, exception) {
                    	$('#imgPic_'+this.n).attr('src','');
                        var errmsg = this.url+'資料寫入異常。\n';
                        if (jqXHR.status === 0) {
                            alert(errmsg+'Not connect.\n Verify Network.');
                        } else if (jqXHR.status == 404) {
                            alert(errmsg+'Requested page not found. [404]');
                        } else if (jqXHR.status == 500) {
                            alert(errmsg+'Internal Server Error [500].');
                        } else if (exception === 'parsererror') {
                            alert(errmsg+'Requested JSON parse failed.');
                        } else if (exception === 'timeout') {
                            alert(errmsg+'Time out error.');
                        } else if (exception === 'abort') {
                            alert(errmsg+'Ajax request aborted.');
                        } else {
                            alert(errmsg+'Uncaught Error.\n' + jqXHR.responseText);
                        }
                    }
                });
			}
			Date.prototype.Format = function (fmt) { 
			    var o = {
			        "M+": this.getMonth() + 1, //月份 
			        "d+": this.getDate(), //日 
			        "h+": this.getHours(), //小时 
			        "m+": this.getMinutes(), //分 
			        "s+": this.getSeconds(), //秒 
			        "q+": Math.floor((this.getMonth() + 3) / 3), //季度 
			        "S": this.getMilliseconds() //毫秒 
			    };
			    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
			    for (var k in o)
			    if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
			    return fmt;
			};
		</script>
		<style type="text/css">
            #dmain {
                overflow: visible;
            }
            .dview {
                float: left;
                width: 300px;
                border-width: 0px;
            }
            .tview {
                border: 5px solid gray;
                font-size: medium;
                background-color: black;
            }
            .tview tr {
                height: 30%;
            }
            .tview td {
                padding: 2px;
                text-align: center;
                border-width: 0px;
                background-color: #FFFF66;
                color: blue;
            }
            .dbbm {
                float: left;
                width: 70%;
                /*margin: -1px;
                 border: 1px black solid;*/
                border-radius: 5px;
            }
            .tbbm {
                padding: 0px;
                border: 1px white double;
                border-spacing: 0;
                border-collapse: collapse;
                font-size: medium;
                color: blue;
                background: #cad3ff;
                width: 100%;
            }
            .tbbm tr {
                height: 35px;
            }
            .tbbm tr td {
                width: 9%;
            }
            .tbbm .tdZ {
                width: 1%;
            }
            .tbbm tr td span {
                float: right;
                display: block;
                width: 5px;
                height: 10px;
            }
            .tbbm tr td .lbl {
                float: right;
                color: blue;
                font-size: medium;
            }
            .tbbm tr td .lbl.btn {
                color: #4297D7;
                font-weight: bolder;
                font-size: medium;
            }
            .tbbm tr td .lbl.btn:hover {
                color: #FF8F19;
            }
            .txt.c1 {
                width: 100%;
                float: left;
            }
            .txt.c2 {
                width: 130%;
                float: left;
            }
            .txt.c3 {
                width: 45%;
                float: right;
            }
            .txt.num {
                text-align: right;
            }
            .tbbm td {
                margin: 0 -1px;
                padding: 0;
            }
            .tbbm td input[type="text"] {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
                float: left;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            .dbbs {
                width: 1700px;
            }
            .dbbs .tbbs {
                margin: 0;
                padding: 2px;
                border: 2px lightgrey double;
                border-spacing: 1;
                border-collapse: collapse;
                font-size: medium;
                color: blue;
                /*background: #cad3ff;*/
                background: lightgrey;
                width: 1700px;
            }
            .dbbs .tbbs tr {
                height: 35px;
            }
            .dbbs .tbbs tr td {
                text-align: center;
                border: 2px lightgrey double;
            }
            .dbbs .tbbs select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
                font-size: medium;
            }
            #dbbt {
                width: 1500px;
            }
            #tbbt {
                margin: 0;
                padding: 2px;
                border: 2px pink double;
                border-spacing: 1;
                border-collapse: collapse;
                font-size: medium;
                color: blue;
                background: pink;
                width: 100%;
            }
            #tbbt tr {
                height: 35px;
            }
            #tbbt tr td {
                text-align: center;
                border: 2px pink double;
            }
            #InterestWindows {
                display: none;
                width: 20%;
                background-color: #cad3ff;
                border: 5px solid gray;
                position: absolute;
                z-index: 50;
            }
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<!--#include file="../inc/toolbar.inc"-->
		<div id="divImport" style="position:absolute; top:100px; left:400px; display:none; width:400px; height:170px; background-color: pink; border: 5px solid gray;">
			<table style="width:100%;">
				<tr style="height:1px;">
					<td style="width:80px;"></td>
					<td style="width:220px;"></td>
					<td style="width:40px;"></td>
				</tr>
				<tr style="height:35px;">
					<td><span> </span><a id="lblPrint_d" style="float:right; color: blue; font-size: medium;"> </a></td>
					<td colspan="4">
						<select id="combPrint" style="font-size: medium;width:80%;">
							<option value="barfe1-1.bat">白色、紫色</option>
							<option value="barfe1-2.bat">綠色</option>
							<option value="barfe1-3.bat">黃色、膚色</option>
							<option value="barfe1-4.bat">藍色、桃紅色</option>
							<option value="barfe2-1.bat">條碼2</option>
							
						</select>
					</td>
					<td></td>
					<td><input id="btnPrint_d" type="button" value="列印"/></td>
				</tr>
				<tr style="height:20px;">
					<td colspan="6">
						<a style="color:darkred;">&nbsp;&nbsp;&nbsp;&nbsp;【列印】有勾、【品名】有輸入的才會印。</a>
					</td>
					<td><input id="btnCancel_d" type="button" value="關閉"/></td>
				</tr>
				<tr style="height:20px;">
					<td colspan="7"><a style="font-size:8px; color:darkblue;">Chrome 若無看見確認視窗</a></td>
				</tr>
				<tr style="height:20px;">
					<td colspan="7"><a style="font-size:8px; color:darkblue;">請至【設定】->【隱私權】(內容設定)->【彈出視窗】(管理例外情況)</a></td>
				</tr>
			</table>
		</div>
		<div id="divChk" style="position:absolute; top:100px; left:400px; display:none; width:400px; height:80px; background-color: pink; border: 5px solid gray;">
			<table style="width:100%;">
				<tr style="height:1px;">
					<td style="width:80px;"></td>
					<td style="width:220px;"></td>
					<td style="width:40px;"></td>
				</tr>
				<tr style="height:20px;">
					<td><span> </span><a id="lblChecker" class="lbl">複檢人</a></td>
					<td><input id="textChecker" type="text" class="txt c1"/></td>
					<td><input id="btnCancel_c" type="button" value="關閉"/></td>
				</tr>
			</table>
		</div>
		<div id='dmain' style="overflow:visible;width: 1200px;">
			<div class="dview" id="dview" >
				<table class="tview" id="tview" >
					<tr>
						<td style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td style="width:100px; color:black;"><a id='vewCust'> </a></td>
						<td style="width:100px; color:black;"><a id='vewDatea'> </a></td>
						<td style="width:100px; color:black;"><a id='vewOdate'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td id='nick' style="text-align: center;">~nick</td>
						<td id='datea' style="text-align: center;">~datea</td>
						<td id='odate' style="text-align: center;">~odate</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr style="height:1px;">
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td class="tdZ"></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td colspan="2">
						<input id="txtNoa"  type="text" class="txt c1"/>
						</td>
						<td><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td><input id="txtDatea"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id="lblOdate" class="lbl"> </a></td>
						<td><input id="txtOdate"  type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblCust" class="lbl btn"> </a></td>
						<td colspan="2">
							<input id="txtCustno"  type="text"  class="txt" style="width:45%;float:left;"/>
							<input id="txtCust"  type="text"  class="txt" style="width:55%;float:left;"/>
							<input id="txtNick"  type="text"  class="txt" style="display:none;"/>
						</td>
						<td><span> </span><a id="lblTrantype" class="lbl"> </a></td>
						<td><select id="cmbTrantype" class="txt c1"></select></td>
						<td><select id="cmbTrantype1" class="txt c1"></select></td>
						<td><select id="cmbTrantype2" class="txt c1"></select></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblSite" class="lbl"> </a></td>
						<td colspan="2"><input id="txtSite"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id="lblTagcolor" class="lbl"> </a></td>
						<td><select id="cmbTagcolor" class="txt c1"></select></td>
						<td><span> </span><a id="lblTolerance" class="lbl"> </a></td>
						<td><input id="txtTolerance"  type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td colspan="2" rowspan="2"><textarea id="txtMemo" class="txt c1" rows="3"></textarea></td>
						<td><span> </span><a id="lblChktype" class="lbl"> </a></td>
						<td><input id="txtChktype"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id="lblMount" class="lbl"> </a></td>
						<td><input id="txtMount"  type="text"  class="num txt c1"/></td>
					</tr>
					<tr>
						<td></td>
						<td style="text-align: center;">
							<input type="button" id="btnBarcode" value="條碼列印" />
						</td>
						<td>
							<input type="button" id="btnChecker" value="複檢人" />
							<input id="txtChecker" type="text" class="txt c3"/>
						</td>
						<td><span> </span><a id="lblWeight" class="lbl"> </a></td>
						<td><input id="txtWeight"  type="text"  class="num txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td><input id="txtWorker" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblWorker2" class="lbl"> </a></td>
						<td><input id="txtWorker2" type="text" class="txt c1"/></td>
						<td><input type="button" id="btnCont" value="合約匯入" /></td>
						<td><span> </span><a id="lblOrdeno" class="lbl btn"> </a></td>
						<td>
							<input id="txtOrdeno"  type="text"  class="txt c1"/>
							<input id="txtOrdeaccy"  type="text"  style="display:none;"/>
							<input type="button" id="btnOrde" value="轉訂單" style="display:none;"/>
						</td>
					</tr>				
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td style="width:20px;">
						<input id="btnPlus" type="button" style="font-size: medium; font-weight: bold;" value="＋"/>
					</td>
					<td style="width:20px;"> </td>
					<td style="width:20px;">列印<input class="checkAll" type="checkbox" onclick="checkAll()"/></td>
					<td style="width:380px;"><a id='lbl_product'>品名</a><br><a id='lbl_memo'>備註</a></td>
					<td style="width:80px;"><a id='lbl_pic'>位置</a></td>
					<td style="width:170px;"><a id='lbl_pic'>形狀</a></td>
					<td style="width:80px;"><a id='lbl_picno'>形狀<br>編號</a></td>
					<td style="width:60px;"><a id='lbl_imgparaa'>參數A</a></td>
					<td style="width:60px;"><a id='lbl_imgparab'>參數B</a></td>
					<td style="width:60px;"><a id='lbl_imgparac'>參數C</a></td>
					<td style="width:60px;"><a id='lbl_imgparad'>參數D</a></td>
					<td style="width:60px;"><a id='lbl_imgparae'>參數E</a></td>
					<td style="width:60px;"><a id='lbl_imgparaf'>參數F</a></td>
					<td style="width:80px;"><a id='lbl_lengthb'>長度</a><br><a id='lbl_monnt'>數量</a><br><a id='lbl_weight'>重量</a></td>
					<td style="width:150px;"><a id='lbl_mech'>機台</a></td>
					<td style="width:100px;"><a id='lbl_place'>儲位</a></td>
					<td style="width:180px;"><a id='lbl_timea'>加工時間</a></td>
					<td style="width:100px;"><a id='lbl_worker'>入庫人員</a></td>
					<td style="width:180px;"><a id='lbl_cont'>合約單號</a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
						<input id="btnMinus.*" type="button" style="font-size: medium; font-weight: bold;" value="－"/>
						<input id="txtNoq.*" type="text" style="display: none;"/>
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td align="center"><input id="checkIsprint.*" class="justPrint" type="checkbox"/></td>
					<td>
						<input class="txt" id="txtProductno.*" type="text" style="width:35%; float:left;"/>
						<input class="txt" id="txtProduct.*" type="text" style="width:60%;float:left;"/>
						<input class="txt" id="txtMemo.*" type="text" style="width:95%;" title="備註輸入 * ，單支長可手動輸入。"/>
						<input class="txt" id="txtCmount.*" type="text" style="display:none;"/>
						<input class="txt" id="txtCweight.*" type="text" style="display:none;"/>
						<input id="btnProduct.*" type="button" style="display:none;">
					</td>
					<td>
						<input class="txt" id="txtPlace.*" type="text" style="width:95%;" title=""/>
					</td>
					<td>
						<img id="imgPic.*" src="" style="width:150px;height:50px;"/>
						<textarea id="txtImgdata.*" style="display:none;"> </textarea>
					</td>
					<td>
						<input class="txt" id="txtPicno.*" type="text" style="width:95%;"/>
						<input class="txt" id="txtPara.*" type="text" style="display:none;"/>
						<input id="btnPicno.*" type="button" style="display:none;">
					</td>
					<td style="background-color: burlywood;">
						<input class="txt" id="txtParaa.*" type="text" style="width:95%;text-align: right;"/>
					</td>
					<td style="background-color: burlywood;">
						<input class="txt" id="txtParab.*" type="text" style="width:95%;text-align: right;"/>
					</td>
					<td style="background-color: burlywood;">
						<input class="txt" id="txtParac.*" type="text" style="width:95%;text-align: right;"/>
					</td>
					<td style="background-color: burlywood;">
						<input class="txt" id="txtParad.*" type="text" style="width:95%;text-align: right;"/>
					</td>
					<td style="background-color: burlywood;">
						<input class="txt" id="txtParae.*" type="text" style="width:95%;text-align: right;"/>
					</td>
					<td style="background-color: burlywood;">
						<input class="txt" id="txtParaf.*" type="text" style="width:95%;text-align: right;"/>
					</td>
					<td><input class="txt" id="txtLengthb.*" type="text" style="width:95%;text-align: right;" title="備註輸入 * ，單支長可手動輸入。"/>
						<input class="txt" id="txtMount.*" type="text" style="width:95%;text-align: right;"/>
						<input class="txt" id="txtWeight.*" type="text" style="width:95%;text-align: right;"/>
					</td>
					<td>
						<select id="cmbMech1.*" style="width:95%; height:28px;"> </select>
						<select id="cmbMech2.*" style="width:95%; height:28px;"> </select>
						<select id="cmbMech3.*" style="width:95%; height:28px;"> </select>
						<select id="cmbMech4.*" style="width:95%; height:28px;"> </select>
						<select id="cmbMech5.*" style="width:95%; height:28px;"> </select>
					</td>
					<td>
						<input class="txt" id="txtPlace1.*" type="text" style="width:95%;padding: 0px;"/>
						<input class="txt" id="txtPlace2.*" type="text" style="width:95%;padding: 0px;"/>
						<input class="txt" id="txtPlace3.*" type="text" style="width:95%;padding: 0px;"/>
						<input class="txt" id="txtPlace4.*" type="text" style="width:95%;padding: 0px;"/>
						<input class="txt" id="txtPlace5.*" type="text" style="width:95%;padding: 0px;"/>
					</td>
					<td>
						<input class="txt" id="txtTime1.*" type="text" style="width:95%;padding: 0px;"/>
						<input class="txt" id="txtTime2.*" type="text" style="width:95%;padding: 0px;"/>
						<input class="txt" id="txtTime3.*" type="text" style="width:95%;padding: 0px;"/>
						<input class="txt" id="txtTime4.*" type="text" style="width:95%;padding: 0px;"/>
						<input class="txt" id="txtTime5.*" type="text" style="width:95%;padding: 0px;"/>
					</td>
					<td>
						<input class="txt" id="txtWorker1.*" type="text" style="width:95%;padding: 0px;"/>
						<input class="txt" id="txtWorker2.*" type="text" style="width:95%;padding: 0px;"/>
						<input class="txt" id="txtWorker3.*" type="text" style="width:95%;padding: 0px;"/>
						<input class="txt" id="txtWorker4.*" type="text" style="width:95%;padding: 0px;"/>
						<input class="txt" id="txtWorker5.*" type="text" style="width:95%;padding: 0px;"/>
					</td>
					<td>
						<input class="txt" id="txtContno.*" type="text" style="float:left;width:120px;"/>
						<input class="txt" id="txtContnoq.*" type="text" style="float:left;width:35px;"/>
					</td>
				</tr>
			</table>
		</div>
		
		<input id="q_sys" type="hidden" />
		<div id="dbbt" style="display:noxne;">
			<table id="tbbt">
				<tbody>
					<tr class="head" style="color:white; background:#003366;">
						<td style="width:20px;">
						<input id="btnPlut" type="button" style="font-size: medium; font-weight: bold;" value="＋"/>
						</td>
						<td style="width:20px;"> </td>
						<td style="width:20px;">列印<input class="checkAll2" type="checkbox" onclick="checkAll2()"/></td>
						<td style="width:200px; text-align: center;">批號</td>
						<td style="width:200px; text-align: center;">品名</td>
						<td style="width:100px; text-align: center;">數量</td>
						<td style="width:100px; text-align: center;">重量</td>
						<td style="width:200px; text-align: center;">餘料批號</td>
						<td style="width:80px; text-align: center;">長度</td>
						<td style="width:100px; text-align: center;">餘料數量</td>
						<td style="width:100px; text-align: center;">餘料重量</td>
						<td style="width:100px; text-align: center;">儲位</td>
						<td style="width:200px; text-align: center;">備註/爐號</td>
					</tr>
					<tr>
						<td>
							<input id="btnMinut..*"  type="button" style="font-size: medium; font-weight: bold;" value="－"/>
							<input class="txt" id="txtNoq..*" type="text" style="display: none;"/>
						</td>
						<td><a id="lblNo..*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
						<td align="center"><input id="checkIsprint..*" class="justPrint2" type="checkbox"/></td>
						<td>
							<input class="txt" id="txtUno..*" type="text" style="width:95%;"/>
							<input id="btnUno..*" type="button" style="display:none;">
						</td>
						<td>
							<input class="txt" id="txtProductno..*" type="text" style="width:45%;float:left;"/>
							<input class="txt" id="txtProduct..*" type="text" style="width:45%;float:left;"/>
							<input id="btnProduct..*" type="button" style="display:none;">
						</td>
						<td><input class="txt" id="txtGmount..*" type="text" style="width:95%;text-align: right;"/></td>
						<td><input class="txt" id="txtGweight..*" type="text" style="width:95%;text-align: right;"/></td>
						<td><input class="txt" id="txtBno..*" type="text" style="width:95%;"/></td>
						<td><input class="txt" id="txtLengthb..*" type="text" style="width:95%;text-align: right;"/></td>
						<td><input class="txt" id="txtMount..*" type="text" style="width:95%;text-align: right;"/></td>
						<td><input class="txt" id="txtWeight..*" type="text" style="width:95%;text-align: right;"/></td>
						<td>
							<input class="txt" id="txtPlace..*" type="text" style="width:95%;" />
							<input class="txt" id="txtStoreno..*" type="text" style="display:none;"/>
							<input class="txt" id="txtStore..*" type="text" style="display:none;"/>
							<input id="btnStore..*" type="button" style="display:none;">
						</td>
						<td><input class="txt" id="txtMemo..*" type="text" style="width:95%;" /></td>
					</tr>
				</tbody>
			</table>
		</div>
	</body>
</html>