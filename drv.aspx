<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">

			var q_name = "drv";
			
			aPop = new Array(
				['textDriverno', 'lblDriver', 'sss', 'noa,namea', 'textDriverno,textDriver', 'sss_b.aspx']
				,['textCustno', 'lblCust', 'cust', 'noa,comp', 'textCustno', 'cust_b.aspx']
				,['textHandle_0', '', 'sss', 'noa,namea', '0textHandle_0,textHandle_0', 'sss_b.aspx']
				,['textHandle_1', '', 'sss', 'noa,namea', '0textHandle_1,textHandle_1', 'sss_b.aspx']
				,['textHandle_2', '', 'sss', 'noa,namea', '0textHandle_2,textHandle_2', 'sss_b.aspx']
				,['textHandle_3', '', 'sss', 'noa,namea', '0textHandle_3,textHandle_3', 'sss_b.aspx']
				,['textHandle_4', '', 'sss', 'noa,namea', '0textHandle_4,textHandle_4', 'sss_b.aspx']
				,['textHandle_5', '', 'sss', 'noa,namea', '0textHandle_5,textHandle_5', 'sss_b.aspx']
				,['textHandle_6', '', 'sss', 'noa,namea', '0textHandle_6,textHandle_6', 'sss_b.aspx']
				,['textHandle_7', '', 'sss', 'noa,namea', '0textHandle_7,textHandle_7', 'sss_b.aspx']
				,['textHandle_8', '', 'sss', 'noa,namea', '0textHandle_8,textHandle_8', 'sss_b.aspx']
				,['textHandle_9', '', 'sss', 'noa,namea', '0textHandle_9,textHandle_9', 'sss_b.aspx']
				,['textHandle2_0', '', 'sss', 'noa,namea', '0textHandle2_0,textHandle2_0', 'sss_b.aspx']
				,['textHandle2_1', '', 'sss', 'noa,namea', '0textHandle2_1,textHandle2_1', 'sss_b.aspx']
				,['textHandle2_2', '', 'sss', 'noa,namea', '0textHandle2_2,textHandle2_2', 'sss_b.aspx']
				,['textHandle2_3', '', 'sss', 'noa,namea', '0textHandle2_3,textHandle2_3', 'sss_b.aspx']
				,['textHandle2_4', '', 'sss', 'noa,namea', '0textHandle2_4,textHandle2_4', 'sss_b.aspx']
				,['textHandle2_5', '', 'sss', 'noa,namea', '0textHandle2_5,textHandle2_5', 'sss_b.aspx']
				,['textHandle2_6', '', 'sss', 'noa,namea', '0textHandle2_6,textHandle2_6', 'sss_b.aspx']
				,['textHandle2_7', '', 'sss', 'noa,namea', '0textHandle2_7,textHandle2_7', 'sss_b.aspx']
				,['textHandle2_8', '', 'sss', 'noa,namea', '0textHandle2_8,textHandle2_8', 'sss_b.aspx']
				,['textHandle2_9', '', 'sss', 'noa,namea', '0textHandle2_9,textHandle2_9', 'sss_b.aspx']
			);
			
			var chk_vcce=''; //儲存要派車的訂單資料
			var chk_handle=new Array(); //儲存要派車的理貨人
			var chk_handle2=new Array(); //儲存要派車的理貨人2
			var chk_store=new Array(); //儲存要派車的倉庫
			
			function orde() {
            }
            orde.prototype = {
                data : null,
                tbCount : 10,
                curPage : -1,
                totPage : 0,
                curIndex : '',
                curCaddr : null,
                lock : function(){
                    for(var i=0;i<this.tbCount;i++){
                        if($('#orde_chk' + i).attr('disabled')!='disabled'){
                            $('#orde_chk' + i).addClass('lock').attr('disabled', 'disabled');
                        }
                    }
                },
                unlock : function(){
                    for(var i=0;i<this.tbCount;i++){
                        if($('#orde_chk' + i).hasClass('lock')){
                            $('#orde_chk' + i).removeClass('lock').removeAttr('disabled');
                        }
                    }
                },
                load : function(){
                    var string = "<table id='orde_table' style='width:1560px;'>";
                    string+='<tr id="orde_header">';
                    string+='<td id="orde_chk" align="center" style="width:20px; color:black;">選</td>';
                    string+='<td id="orde_chk_vcce" align="center" style="width:40px; color:black;">派/次</td>';
                    string+='<td id="orde_sel" align="center" style="width:20px; color:black;"></td>';
                    string+='<td id="orde_datea" onclick="orde.sort(\'datea\',false)" title="預交日" align="center" style="width:65px; color:black;">預交日</td>';
                    string+='<td id="orde_timea" onclick="orde.sort(\'timea\',false)" title="時間" align="center" style="width:60px; color:black;">時間</td>';
                    string+='<td id="orde_comp" onclick="orde.sort(\'comp\',false)" title="公司名稱" align="center" style="width:150px; color:black;">公司名稱</td>';
                    string+='<td id="orde_trantype" onclick="orde.sort(\'trantype\',false)" title="交運" align="center" style="width:80px; color:black;">交運</td>';
                    string+='<td id="orde_memo" onclick="orde.sort(\'memo\',false)" title="備註" align="center" style="width:120px; color:black;">備註</td>';
                    string+='<td id="orde_handle" title="理貨員" align="center" style="width:100px; color:black;">理貨員</td>';
                    string+='<td id="orde_handle2" title="理貨員2" align="center" style="width:100px; color:black;">理貨員2</td>';
                    string+='<td id="orde_sales" onclick="orde.sort(\'sales\',false)" title="業務" align="center" style="width:80px; color:black;">業務</td>';
                    string+='<td id="orde_tel" onclick="orde.sort(\'tel\',false)" title="電話" align="center" style="width:80px; color:black;">電話</td>';
                    string+='<td id="orde_worker" onclick="orde.sort(\'worker\',false)" title="操作員" align="center" style="width:70px; color:black;">操作員</td>';
                    string+='<td id="orde_noa" onclick="orde.sort(\'noa\',false)" title="訂單號碼" align="center" style="width:90px; color:black;">訂單號碼</td>';
                    string+='<td id="orde_odate" onclick="orde.sort(\'odate\',false)" title="訂購日期" align="center" style="width:65px; color:black;">訂購日期</td>';
                    string+='<td id="orde_enda" onclick="orde.sort(\'enda\',false)" title="結案" align="center" style="width:30px; color:black;">結案</td>';
                    string+='</tr>';
                    
                    var t_color = ['DarkBlue','DarkRed'];
                    for(var i=0;i<this.tbCount;i++){
                        string+='<tr id="orde_tr'+i+'">';
                        string+='<td style="text-align: center;">';
                        string+='<input id="orde_chk'+i+'" class="orde_chk" type="checkbox"/></td>';
                        string+='<td style="text-align: center;"><input id="orde_chk_vcce'+i+'" class="orde_chk_vcce" namea="vcce" type="checkbox"/>';
                        string+='<a id="orde_vcce'+i+'" style="color:'+t_color[i%t_color.length]+'"></a></td>';
                        string+='<td style="text-align: center; font-weight: bolder; color:black;">'+(i+1)+'</td>';
                        string+='<td id="orde_datea'+i+'" onclick="orde.browNoa(this)" style="text-align: center;color:'+t_color[i%t_color.length]+'"></td>';
                        string+='<td id="orde_timea'+i+'" style="text-align: center;color:'+t_color[i%t_color.length]+'"></td>';
                        string+='<td id="orde_comp'+i+'" style="text-align: center;color:'+t_color[i%t_color.length]+'"></td>';
                        string+='<td id="orde_trantype'+i+'" style="text-align: center;color:'+t_color[i%t_color.length]+'"></td>';
                        string+='<td id="orde_memo'+i+'" style="text-align: center;color:'+t_color[i%t_color.length]+'"></td>';
                        string+='<td id="orde_handle'+i+'" style="text-align: center;color:'+t_color[i%t_color.length]+'"><input id="textHandle_'+i+'"  type="text" class="handle txt" style="width: 100px;"/></td>';
                        string+='<td id="orde_handle2'+i+'" style="text-align: center;color:'+t_color[i%t_color.length]+'"><input id="textHandle2_'+i+'"  type="text" class="handle2 txt" style="width: 100px;"/></td>';
                        string+='<td id="orde_sales'+i+'" style="text-align: center;color:'+t_color[i%t_color.length]+'"></td>';
                        string+='<td id="orde_tel'+i+'" style="text-align: center;color:'+t_color[i%t_color.length]+'"></td>';
                        string+='<td id="orde_worker'+i+'" style="text-align: center;color:'+t_color[i%t_color.length]+'"></td>';
                        string+='<td id="orde_noa'+i+'" style="text-align: center;color:'+t_color[i%t_color.length]+'"></td>';
                        string+='<td id="orde_odate'+i+'" style="text-align: center;color:'+t_color[i%t_color.length]+'"></td>';
                        string+='<td id="orde_enda'+i+'" style="text-align: center;color:'+t_color[i%t_color.length]+'"><input class="orde_btn" id="btnEnda_'+i+'" type="button" value="."" style=" font-weight: bold;" /></td>';
                        string+='</tr>';
                    }
                    string+='</table>';
                    
                    $('#orde').append(string);
                    string='';
                    string+='<a id="lblCust" style="float:left;">客戶編號</a><input id="textCustno"  type="text" style="float:left;width:130px;"/>';
                    string+='<a style="float:left;">訂單編號</a><input id="textNoa"  type="text" style="float:left;width:130px;"/>';
                    string+='<a style="float:left;">預交日</a><input id="textBdate"  type="text" style="float:left;width:80px;"/><a style="float:left;">~</a><input id="textEdate"  type="text" style="float:left;width:80px;"/>';
                    string+='<input id="btnOrde_refresh"  type="button" style="float:left;width:100px;" value="訂單刷新"/>';
                    string+='<input id="btnOrde_previous" onclick="orde.previous()" type="button" style="float:left;width:100px;" value="上一頁"/>';
                    string+='<input id="btnOrde_next" onclick="orde.next()" type="button" style="float:left;width:100px;" value="下一頁"/>';
                    string+='<input id="textCurPage" onchange="orde.page(parseInt($(this).val()))" type="text" style="float:left;width:100px;text-align: right;"/>';
                    string+='<span style="float:left;display:block;width:10px;font-size: 25px;">/</span>';
                    string+='<input id="textTotPage"  type="text" readonly="readonly" style="float:left;width:100px;color:green;"/>';
                    $('#orde_control').append(string);
                    
                    $('#textBdate').mask('999/99/99');
                    $('#textEdate').mask('999/99/99');
                    
                },
                init : function(obj) {
					//chk_vcce='';
					chk_handle=new Array();
					chk_handle2=new Array();
					chk_store=new Array();
					
					$('.orde_chk').unbind('click');
                    $('.orde_chk').click(function(e) {
                        $(".orde_chk").not(this).prop('checked', false);
                        $(".orde_chk").not(this).parent().parent().find('td').css('background', 'pink');
                        $(this).prop('checked', true);
                        $(this).parent().parent().find('td').css('background', '#FF8800');
                        
                        //顯示BBS的資料
                        var n=$(this).attr('id').replace('orde_chk','')
                        orde_n=n;
                        var t_where="where=^^noa='"+$('#orde_noa'+n).text()+"' and isnull(enda,'0')!='1' and isnull(cancel,'0')!='1' ^^";
						q_gt('view_ordes', t_where, 0, 0, 0,'show_ordes', r_accy);
                        $('#ordes').html('');
                        $('#div_stk').hide();
                        
                        //顯示Workjs的資料
                        var t_where="where=^^ordeno='"+$('#orde_noa'+n).text()+"' ^^";
						q_gt('workj', t_where, 0, 0, 0,'show_workjs', r_accy);
						$('#workjs').html('');
                    });
                    
                    //結案
                    $('.orde_btn').unbind('click');
                    $('.orde_btn').click(function(e) {
                        //顯示BBS的資料
                        var n=$(this).attr('id').replace('btnEnda_','')
                        orde_n=n;
                        if(confirm("確定要結案?")){
                        	q_func('qtxt.query.ordeenda', 'drv.txt,ordeenda,'+$('#orde_noa'+n).text()+';'+r_accy+';'+r_userno+';'+r_name);
                        	enda_page=dec($('#textCurPage').val());
                        }
                    });
                    
                    $('.orde_chk_vcce').unbind('click');
                    $('.orde_chk_vcce').click(function(e) {
                        //儲存核取的訂單
                        var n=$(this).attr('id').replace('orde_chk_vcce','')
                        var ordeno=$('#orde_noa'+n).text();
                        if($(this).prop('checked')){
                        	chk_vcce=chk_vcce.replace(ordeno+'#','')+ordeno+'#';
                        }else{
                        	chk_vcce=chk_vcce.replace(ordeno+'#','');
                        }
                        
                        //處理理貨員
                        for(var i =0 ;i<chk_handle.length;i++){
                        	if(chk_handle[i].noa==$('#orde_noa'+n).text()){
                        		chk_handle.splice(i, 1);
                        		break;
                        	}
                        }
                        if( $('#textHandle_'+n).val().length>0 && $('#orde_chk_vcce'+n).prop('checked')){
	                        chk_handle.push({
								noa : $('#orde_noa'+n).text(),
								handle : $('#textHandle_'+n).val()
							});
						}
						//處理理貨員2
						for(var i =0 ;i<chk_handle2.length;i++){
                        	if(chk_handle2[i].noa==$('#orde_noa'+n).text()){
                        		chk_handle2.splice(i, 1);
                        		break;
                        	}
                        }
                        if( $('#textHandle2_'+n).val().length>0 && $('#orde_chk_vcce'+n).prop('checked')){
	                        chk_handle2.push({
								noa : $('#orde_noa'+n).text(),
								handle : $('#textHandle2_'+n).val()
							});
						}
						//處理倉庫
						if(n==orde_n){
							for(var i =0 ;i<chk_store.length;i++){
		                        if(chk_store[i].noa==$('#orde_noa'+n).text() && !$('#orde_chk_vcce'+n).prop('checked')){
		                        	chk_store.splice(i, 1);
		                        	i--;
		                        }
							}
							
							for(var i =0 ;i<ordes_count;i++){
								if( $('#textStore'+i).val().length>0 && $('#orde_chk_vcce'+n).prop('checked')){
									chk_store.push({
										noa : $('#ordes_noa'+i).text(),
										no2 : $('#ordes_no2'+i).text(),
										store : $('#textStore'+i).val()
									});
								}
							}
						}else{
							for(var i =0 ;i<chk_store.length;i++){
		                        if(chk_store[i].noa==$('#orde_noa'+n).text() && !$('#orde_chk_vcce'+n).prop('checked')){
		                        	chk_store.splice(i, 1);
		                        	i--;
		                        }
							}
						}
                    });
                    
                    $('.handle').unbind('blur');
                    $('.handle').blur(function(e) {
                        var n=$(this).attr('id').replace('textHandle_','')
                        
                        for(var i =0 ;i<chk_handle.length;i++){
                        	if(chk_handle[i].noa==$('#orde_noa'+n).text()){
                        		chk_handle.splice(i, 1);
                        		break;
                        	}
                        }
                        
                        if( $('#textHandle_'+n).val().length>0 && $('#orde_chk_vcce'+n).prop('checked')){
	                        chk_handle.push({
								noa : $('#orde_noa'+n).text(),
								handle : $('#textHandle_'+n).val()
							});
						}
                    });
                    
                    $('.handle2').unbind('blur');
                    $('.handle2').blur(function(e) {
                        var n=$(this).attr('id').replace('textHandle2_','')
                        
                        for(var i =0 ;i<chk_handle2.length;i++){
                        	if(chk_handle2[i].noa==$('#orde_noa'+n).text()){
                        		chk_handle2.splice(i, 1);
                        		break;
                        	}
                        }
                        if( $('#textHandle2_'+n).val().length>0 && $('#orde_chk_vcce'+n).prop('checked')){
	                        chk_handle2.push({
								noa : $('#orde_noa'+n).text(),
								handle : $('#textHandle2_'+n).val()
							});
						}
                    });
                    
                    this.data = new Array();
                    if (obj[0] != undefined) {
                        for (var i in obj)
                            if (obj[i]['noa'] != undefined ){
                                this.data.push(obj[i]);
                            }
                    }
                    this.totPage = Math.ceil(this.data.length / this.tbCount);
                    $('#textTotPage').val(this.totPage);
                    this.sort('datea', false);
                    
                    if(enda_page>1){
                    	if(enda_page>dec($('#textTotPage').val()))
                    		enda_page=dec($('#textTotPage').val());
                    	this.curPage=enda_page;
	                    $('#textCurPage').val(this.curPage);
	                    enda_page=1;
	                    this.refresh();
                    }
                    
                    Unlock();
                },
                sort : function(index, isFloat) {
                    //訂單排序
                    this.curIndex = index;

                    if (isFloat) {
                        this.data.sort(function(a, b) {
                            var m = parseFloat(a[orde.curIndex] == undefined ? "0" : a[orde.curIndex]);
                            var n = parseFloat(b[orde.curIndex] == undefined ? "0" : b[orde.curIndex]);
                            if (m == n) {
                                if (a['noa'] < b['noa'])
                                    return 1;
                                if (a['noa'] > b['noa'])
                                    return -1;
                                return 0;
                            } else
                                return n - m;
                        });
                    } else {
                        this.data.sort(function(a, b) {
                            var m = a[orde.curIndex] == undefined ? "" : a[orde.curIndex];
                            var n = b[orde.curIndex] == undefined ? "" : b[orde.curIndex];
                            if (m == n) {
                                if (a['noa'] < b['noa'])
                                    return 1;
                                if (a['noa'] > b['noa'])
                                    return -1;
                                return 0;
                            } else {
                                if (m < n)
                                    return 1;
                                if (m > n)
                                    return -1;
                                return 0;
                            }
                        });
                    }
                    this.page(1);
                },
                next : function() {
                    if (this.curPage == this.totPage) {
                        alert('最末頁。');
                        return;
                    }
                    this.curPage++;
                    $('#textCurPage').val(this.curPage);
                    this.refresh();
                },
                previous : function() {
                    if (this.curPage == 1) {
                        alert('最前頁。');
                        return;
                    }
                    this.curPage--;
                    $('#textCurPage').val(this.curPage);
                    this.refresh();
                },
                page : function(n) {
                    if (n <= 0 || n > this.totPage) {
                        this.curPage = 1;
                        $('#textCurPage').val(this.curPage);
                        this.refresh();
                        return;
                    }
                    this.curPage = n;
                    $('#textCurPage').val(this.curPage);
                    this.refresh();
                },
                refresh : function() {
                    //頁面更新
                    var n = (this.curPage - 1) * this.tbCount;
                    for (var i = 0; i < this.tbCount; i++) {
                        if ((n + i) < this.data.length) {
                            $('#orde_chk' + i).removeAttr('disabled');
                            $('#orde_chk_vcce' + i).removeAttr('disabled');
                            if(chk_vcce.indexOf(this.data[n+i]['noa'])>-1){
                            	$('#orde_chk_vcce' + i).prop('checked', true);
                            }else{
                            	$('#orde_chk_vcce' + i).prop('checked', false);
                            }
                            $('#orde_vcce' + i).html('/'+dec(this.data[n+i]['vcce']));
                            $('#orde_datea' + i).html(this.data[n+i]['datea']);
                            $('#orde_timea' + i).html(this.data[n+i]['timea']);
                            $('#orde_comp' + i).html(this.data[n+i]['comp']);
                            $('#orde_trantype' + i).html(this.data[n+i]['trantype']);
                            $('#orde_memo' + i).html(this.data[n+i]['memo']);
                            $('#orde_sales' + i).html(this.data[n+i]['sales']);
                            $('#orde_tel' + i).html(this.data[n+i]['tel']);  
                            $('#orde_worker' + i).html(this.data[n+i]['worker']);  
                            $('#orde_noa' + i).html(this.data[n+i]['noa']);
                            $('#orde_odate' + i).html(this.data[n+i]['odate']);
                            //$('#orde_enda' + i).html(this.data[n+i]['enda']="false"?'N':'Y');
                            $('#textHandle_'+i).val('');
                            $('#textHandle2_'+i).val('');
                            //理貨員寫入
                            for(var j =0 ;j<chk_handle.length;j++){
                            	if(chk_handle[j].noa==$('#orde_noa' + i).text()){
                            		$('#textHandle_'+i).val(chk_handle[j].handle);
                            		break;
                            	}
                            }
                            for(var j =0 ;j<chk_handle2.length;j++){
                            	if(chk_handle2[j].noa==$('#orde_noa' + i).text()){
                            		$('#textHandle2_'+i).val(chk_handle2[j].handle);
                            		break;
                            	}
                            }
                        } else {
                            $('#orde_chk' + i).attr('disabled', 'disabled');
                            $('#orde_chk_vcce' + i).attr('disabled', 'disabled');
                            $('#orde_chk_vcce' + i).prop('checked', false);
                            $('#orde_vcce' + i).text('');
                            $('#orde_datea' + i).html('');
                            $('#orde_timea' + i).html('');
                            $('#orde_comp' + i).html('');
                            $('#orde_trantype' + i).html('');
                            $('#orde_memo' + i).html('');
                            $('#orde_sales' + i).html('');
                            $('#orde_tel' + i).html('');
                            $('#orde_worker' + i).html('');
                            $('#orde_noa' + i).html('');
                            $('#orde_odate' + i).html('');
                            //$('#orde_enda' + i).html('');
                            //理貨員寫入
                            $('#textHandle_'+i).val('');
                            $('#textHandle2_'+i).val('');
                        }
                    }
                    $('#orde_chk0').click();
                    $('#orde_chk0').prop('checked', 'true');
                },
                browNoa : function(obj){
                    //瀏覽訂單
                    var noa = $.trim($(obj).html());
                    if(noa.length>0)
                       q_gt("view_orde", "where=^^ noa='"+noa+"'^^", 0, 0, 0, 'getordeAccy_'+noa, r_accy);
                },
                loadcaddr : function(ordeno){
                    if(ordeno.length == 0)
                        return;
                    var t_where = "where=^^ noa='"+ordeno+"'^^";
                    q_gt('view_orde', t_where, 0, 0, 0,'loadcaddr', r_accy);
                }
            };
            orde = new orde();

			$(document).ready(function() {		
				_q_boxClose();
                q_getId();
                q_gf('', q_name);
                orde.load();
			});
			
			function q_gfPost() {
				q_getFormat();
                q_langShow();
                q_popAssign();
                q_cur=2;
                
                t_where="where=^^1=1 and isnull(enda,'0')!='1' and isnull(cancel,'0')!='1' ^^";
				q_gt('view_orde', t_where, 0, 0, 0,'aaa', r_accy);
                
                $('#btnOrde_refresh').click(function(e) {
                    var t_where = "1=1 and isnull(enda,'0')!='1' and isnull(cancel,'0')!='1' ";
                    var t_custno = $('#textCustno').val();
                    var t_noa = $('#textNoa').val();
                    var t_bdate = $('#textBdate').val();
                    var t_edate = $('#textEdate').val();
					t_bdate = t_bdate.length > 0 && t_bdate.indexOf("_") > -1 ? t_bdate.substr(0, t_bdate.indexOf("_")) : t_bdate;  /// 100.  .
					t_edate = t_edate.length > 0 && t_edate.indexOf("_") > -1 ? t_edate.substr(0, t_edate.indexOf("_")) : t_edate;  /// 100.  .
                    
                    t_where += q_sqlPara2("custno", t_custno)
                    + q_sqlPara2("noa", t_noa)+ q_sqlPara2("isnull(datea,'')", t_bdate,t_edate);
                    
                    t_where="where=^^"+t_where+"^^";
                    Lock();
					q_gt('view_orde', t_where, 0, 0, 0,'aaa', r_accy);
                });
                
                $('#btnCancels').click(function(e) {
                   chk_vcce='';
                   chk_handle=new Array();
                   chk_handle2=new Array();
                   chk_store=new Array();
                   orde.refresh();
                });
                
                $('#btnPrints').click(function(e) {
                	if(chk_vcce.length==0){
                		alert('請選擇派車單。');
                		return;
                	}
                	
                	var t_where = "where=^^ charindex(ordeno,'"+chk_vcce+"')>0 ^^ ";
					q_gt('view_vcces', t_where, 0, 0, 0,'check_vcce', '');
                });
                
                $('#btnVcce').click(function(e) {
					if(chk_vcce.length>0){
						if(confirm("確定要轉至派車單?")){
							var t_handle='#non#',t_handle2='#non#';
		                	for(var i =0 ;i<chk_handle.length;i++){
		                		t_handle+=chk_handle[i].noa+"^"+chk_handle[i].handle+"#";
		                	}
		                	for(var i =0 ;i<chk_handle2.length;i++){
		                		t_handle2+=chk_handle2[i].noa+"^"+chk_handle2[i].handle+"#";
		                	}
							
							q_func('qtxt.query.drv2vcce', 'drv.txt,drv2vcce,'+(emp($('#textCarno').val())?'#non':$('#textCarno').val())+';'+(emp($('#textDriverno').val())?'#non':$('#textDriverno').val())+';'+chk_vcce+';'+q_getPara('sys.key_vcce')+';'+r_userno+';'+r_name+';'+t_handle+';'+t_handle2);
						}
					}else
						alert('無核取資料。');
                });
                
                $('#btnEnda').click(function(e) {
                   alert('該功能未開放。');
                });
                
                $('#btnClose_div_stk').click(function() {
					$('#div_stk').toggle();
				});
            }
            
			function q_boxClose(s2) {
				var ret;
				switch (b_pop) {
					case q_name + '_s':
						q_boxClose2(s2);
						break;
				}
				b_pop = '';
			}
			
			var mouse_point;
			var orde_n='';//目前orde的列數
			var ordes_count=0;//目前bbs的資料數
			var workjs_count=0;//目前workjs的資料數
			var bbs_n='';//目前觸發的bbs指標
			var t_ordemount = 0,  t_ordcmount = 0,t_ordeweight = 0,  t_ordcweight = 0;//顯示庫存用
			function q_gtPost(t_name) {
				switch (t_name) {
					case 'show_ordes':
						var as = _q_appendData("view_ordes", "", true);
						ordes_count=as.length;
						
						var string = "<table id='ordes_table' style='width:1480px;'>";
	                    string+='<tr id="ordes_header">';
	                    string+='<td id="ordes_sel" align="center" style="width:20px; color:black;"></td>';
	                    string+='<td id="ordes_sel" align="center" style="width:20px; color:black;">庫存</td>';
	                    string+='<td id="ordes_productno" title="產品編號" align="center" style="width:120px; color:black;">產品編號</td>';
	                    string+='<td id="ordes_product" title="產品名稱" align="center" style="width:180px; color:black;">產品名稱</td>';
	                    string+='<td id="ordes_lengthb" title="米" align="center" style="width:100px; color:black;">米</td>';
	                    string+='<td id="ordes_unit" title="單位" align="center" style="width:40px; color:black;">單位</td>';
	                    string+='<td id="ordes_nmount" title="未交數量" align="center" style="width:100px; color:black;">未交數量</td>';
	                    string+='<td id="ordes_nweight" title="未交重量" align="center" style="width:100px; color:black;">未交重量</td>';
	                    string+='<td id="ordes_store" title="倉庫" align="center" style="width:80px; color:black;">倉庫</td>';
	                    string+='<td id="ordes_memo" title="備註" align="center" style="width:130px; color:black;">備註</td>';
	                    string+='<td id="ordes_enda" title="結案" align="center" style="width:30px; color:black;">結案</td>';
	                    string+='<td id="ordes_datea" title="預交日期" align="center" style="width:70px; color:black;">預交日期</td>';
	                    string+='<td id="ordes_sprice" title="預售基價" align="center" style="width:70px; color:black;">預售基價</td>';
	                    string+='<td id="ordes_vmount" title="交貨數量" align="center" style="width:70px; color:black;">交貨數量</td>';
	                    string+='<td id="ordes_vweight" title="交貨重量" align="center" style="width:70px; color:black;">交貨重量</td>';
	                    string+='<td id="ordes_noa" align="center" style="width:70px; color:black;display:none;">noa</td>';
	                    string+='<td id="ordes_no2" align="center" style="width:70px; color:black;display:none;">no2</td>';
	                    string+='</tr>';
	                    
	                    var t_color = ['DarkBlue','DarkRed'];
	                    for(var i=0;i<as.length;i++){
	                        string+='<tr id="orde_tr'+i+'">';
	                        string+='<td style="text-align: center; font-weight: bolder; color:black;">'+(i+1)+'</td>';
	                        string+='<td style="text-align: center; "><input type="button" id="btnStore'+i+'" class="btnstore" value="." style="font-size:16px;"/></td>';
	                        string+='<td id="ordes_productno'+i+'" style="text-align: center;color:'+t_color[i%t_color.length]+'">'+as[i].productno+'</td>';
	                        string+='<td id="ordes_product'+i+'" style="text-align: center;color:'+t_color[i%t_color.length]+'">'+as[i].product+'</td>';
	                        string+='<td id="ordes_lengthb'+i+'" style="text-align: center;color:'+t_color[i%t_color.length]+'">'+as[i].lengthb+'</td>';
	                        string+='<td id="ordes_unit'+i+'" style="text-align: center;color:'+t_color[i%t_color.length]+'">'+as[i].unit+'</td>';
	                        string+='<td id="ordes_nmount'+i+'" style="text-align: center;color:'+t_color[i%t_color.length]+'">'+q_sub(dec(as[i].mount),dec(as[i].vmount))+'</td>';
	                        string+='<td id="ordes_nweight'+i+'" style="text-align: center;color:'+t_color[i%t_color.length]+'">'+round(q_sub(dec(as[i].weight),dec(as[i].vweight)),2)+'</td>';
	                        string+='<td id="ordes_store'+i+'" style="text-align: center;color:'+t_color[i%t_color.length]+'"><input id="textStore'+i+'"  type="text" class="store txt " style="width: 100px;"/></td>';
	                        string+='<td id="ordes_memo'+i+'" style="text-align: center;color:'+t_color[i%t_color.length]+'">'+as[i].memo+'</td>';
	                        string+='<td id="ordes_enda'+i+'" style="text-align: center;color:'+t_color[i%t_color.length]+'">'+(as[i].enda=='1'?'Y':'N')+'</td>';
	                        string+='<td id="ordes_datea'+i+'" style="text-align: center;color:'+t_color[i%t_color.length]+'">'+as[i].datea+'</td>';
	                        string+='<td id="ordes_sprice'+i+'" style="text-align: center;color:'+t_color[i%t_color.length]+'">'+as[i].sprice+'</td>';
	                        string+='<td id="ordes_vmount'+i+'" style="text-align: center;color:'+t_color[i%t_color.length]+'">'+dec(as[i].vmount)+'</td>';
	                        string+='<td id="ordes_vweight'+i+'" style="text-align: center;color:'+t_color[i%t_color.length]+'">'+round(dec(as[i].vweight),2)+'</td>';
	                        string+='<td id="ordes_noa'+i+'" style="text-align: center;color:'+t_color[i%t_color.length]+';display:none;">'+as[i].noa+'</td>';
	                        string+='<td id="ordes_no2'+i+'" style="text-align: center;color:'+t_color[i%t_color.length]+';display:none;">'+as[i].no2+'</td>';
	                        string+='</tr>';
	                    }
	                    string+='</table>';
	                    
	                    $('#ordes').html(string);
	                    
	                    //寫入store
	                    for(var i=0;i<as.length;i++){
	                    	for(var j =0 ;j<chk_store.length;j++){
	                    		if(chk_store[j].noa==$('#ordes_noa'+i).text() && chk_store[j].no2==$('#ordes_no2'+i).text()){
	                    			$('#textStore'+i).val(chk_store[j].store);
	                    			break;
	                    		}
	                    	}
	                    }
	                    
	                    //事件
	                    $('.store').blur(function(e) {
	                        var n=$(this).attr('id').replace('textStore','')
	                        
	                        for(var i =0 ;i<chk_store.length;i++){
	                        	if(chk_store[i].noa==$('#ordes_noa'+n).text() && chk_store[i].no2==$('#ordes_no2'+n).text()){
	                        		chk_store.splice(i, 1);
	                        		break;
	                        	}
	                        }
	                        
	                        if( $('#textStore'+n).val().length>0 && $('#orde_chk_vcce'+orde_n).prop('checked')){
		                        chk_store.push({
									noa : $('#ordes_noa'+n).text(),
									no2 : $('#ordes_no2'+n).text(),
									store : $('#textStore'+n).val()
								});
							}
	                    });
	                    
	                    $('.btnstore').click(function(e) {
	                        var n=$(this).attr('id').replace('btnStore','')
	                        bbs_n=n;
	                        t_ordemount = 0,  t_ordcmount = 0,t_ordeweight = 0,  t_ordcweight = 0;
	                        if (!emp($('#ordes_productno' + n).text()) && $("#div_stk").is(":hidden")) {
								mouse_point=e;
								document.getElementById("stk_productno").innerHTML = $('#ordes_productno' + n).text();
								document.getElementById("stk_product").innerHTML = $('#ordes_product' + n).text();
																
								//訂單
								var t_where = "where=^^ a.noa='" + $('#ordes_productno' + n).text() + "' ^^";
								q_gt('fe_notv', t_where, 0, 0, 0, "fe_notv", r_accy);
							}
	                    });
						break;
					case 'fe_notv':
						var as = _q_appendData("view_ucaucc", "", true);
						if (as[0] != undefined) {
							t_ordemount = dec(as[0].ordeunmount);
							t_ordcmount = dec(as[0].ordcunmount);
							t_ordeweight = dec(as[0].ordeunweight);
							t_ordcweight = dec(as[0].ordcunweight);
						}
						
						//庫存
						var t_where = "where=^^ ['" + q_date() + "','','" + $('#ordes_productno' + bbs_n).text() + "') ^^";
						q_gt('calstk', t_where, 0, 0, 0, "msg_stk_all", r_accy);
						break;
					case 'msg_stk_all':
						var as = _q_appendData("stkucc", "", true);
						var rowslength=document.getElementById("table_stk").rows.length-3;
							for (var j = 1; j < rowslength; j++) {
								document.getElementById("table_stk").deleteRow(3);
							}
						var stk_row=0;
						
						var stkmount = 0,stkweight = 0;
						for (var i = 0; i < as.length; i++) {
							//倉庫庫存
							if(dec(as[i].mount)!=0){
								var tr = document.createElement("tr");
								tr.id = "bbs_"+j;
								tr.innerHTML = "<td id='assm_tdStoreno_"+stk_row+"'><input id='assm_txtStoreno_"+stk_row+"' type='text' class='txt c1' value='"+as[i].storeno+"' disabled='disabled'/></td>";
								tr.innerHTML+="<td id='assm_tdStore_"+stk_row+"'><input id='assm_txtStore_"+stk_row+"' type='text' class='txt c1' value='"+as[i].store+"' disabled='disabled' /></td>";
								tr.innerHTML+="<td id='assm_tdMount_"+stk_row+"'><input id='assm_txtMount_"+stk_row+"' type='text' class='txt c1 num' value='"+as[i].mount+"' disabled='disabled'/></td>";
								tr.innerHTML+="<td id='assm_tdWeight_"+stk_row+"'><input id='assm_txtWeight_"+stk_row+"' type='text' class='txt c1 num' value='"+as[i].weight+"' disabled='disabled'/></td>";
								var tmp = document.getElementById("stk_close");
								tmp.parentNode.insertBefore(tr,tmp);
								stk_row++;
							}
							//庫存總計
							stkmount=q_add(stkmount,dec(as[i].mount));
							stkweight=q_add(stkweight,dec(as[i].weight));
						}
						var tr = document.createElement("tr");
						tr.id = "bbs_"+j;
						tr.innerHTML="<td colspan='2' id='stk_tdStore_"+stk_row+"' style='text-align: right;'><span id='stk_txtStore_"+stk_row+"' class='txt c1' >+庫存量</span></td>";
						tr.innerHTML+="<td id='stk_tdMount_"+stk_row+"'><span id='stk_txtMount_"+stk_row+"' type='text' class='txt c1 num' > "+stkmount+"</span></td>";
						tr.innerHTML+="<td id='stk_tdWeight_"+stk_row+"'><span id='stk_txtWeight_"+stk_row+"' type='text' class='txt c1 num' > "+stkweight+"</span></td>";
						
						var tmp = document.getElementById("stk_close");
						tmp.parentNode.insertBefore(tr,tmp);
						stk_row++;
						//-------------------------------------------------------------------------------------
						var tr = document.createElement("tr");
						tr.id = "bbs_"+(j+1);
						
						tr.innerHTML="<td colspan='2' id='stk_tdStore_"+stk_row+"' style='text-align: right;'><span id='stk_txtStore_"+stk_row+"' class='txt c1' >-訂單未交</span></td>";
						tr.innerHTML+="<td id='stk_tdOmount_"+stk_row+"'><span id='stk_txtOmount_"+stk_row+"' type='text' class='txt c1 num' > "+t_ordemount+"</span></td>";
						tr.innerHTML+="<td id='stk_tdOweight_"+stk_row+"'><span id='stk_txtOweight_"+stk_row+"' type='text' class='txt c1 num' > "+t_ordeweight+"</span></td>";
						
						var tmp = document.getElementById("stk_close");
						tmp.parentNode.insertBefore(tr,tmp);
						stk_row++;
						//-------------------------------------------------------------------------------------
						var tr = document.createElement("tr");
						tr.id = "bbs_"+(j+2);
						
						tr.innerHTML="<td colspan='2' id='stk_tdStore_"+stk_row+"' style='text-align: right;'><span id='stk_txtStore_"+stk_row+"' class='txt c1' >=可出貨量</span></td>";
						tr.innerHTML+="<td id='stk_tdVmount_"+stk_row+"'><span id='stk_txtVmount_"+stk_row+"' type='text' class='txt c1 num' > "+q_sub(stkmount,t_ordemount)+"</span></td>";
						tr.innerHTML+="<td id='stk_tdVweight_"+stk_row+"'><span id='stk_txtVweight_"+stk_row+"' type='text' class='txt c1 num' > "+q_sub(stkweight,t_ordeweight)+"</span></td>";
						
						var tmp = document.getElementById("stk_close");
						tmp.parentNode.insertBefore(tr,tmp);
						stk_row++;
						//-------------------------------------------------------------------------------------
						var tr = document.createElement("tr");
						tr.id = "bbs_"+(j+3);
						
						tr.innerHTML="<td colspan='2' id='stk_tdStore_"+stk_row+"' style='text-align: right;'><span id='stk_txtStore_"+stk_row+"' class='txt c1' >採購未交</span></td>";
						tr.innerHTML+="<td id='stk_tdCmount_"+stk_row+"'><span id='stk_txtCmount_"+stk_row+"' type='text' class='txt c1 num' > "+t_ordcmount+"</span></td>";
						tr.innerHTML+="<td id='stk_tdCweight_"+stk_row+"'><span id='stk_txtCweight_"+stk_row+"' type='text' class='txt c1 num' > "+t_ordcweight+"</span></td>";
						
						var tmp = document.getElementById("stk_close");
						tmp.parentNode.insertBefore(tr,tmp);
						stk_row++;
						//-------------------------------------------------------------------------------------
						$('#div_stk').css('top',mouse_point.pageY);
						$('#div_stk').css('left',mouse_point.pageX);
						$('#div_stk').toggle();
						break;
					case 'show_workjs':
						var workj = _q_appendData("workj", "", true);
						var workjs = _q_appendData("workjs", "", true);
						workjs_count=workjs.length;
						
						var string = "<table id='workjs_table' style='width:1720px;'>";
	                    string+='<tr id="workjs_header">';
	                    string+='<td id="workjs_sel" align="center" style="width:20px; color:black;"></td>';
	                    string+='<td id="workjs_productno" title="產品編號" align="center" style="width:120px; color:black;">產品編號</td>';
	                    string+='<td id="workjs_product" title="產品名稱" align="center" style="width:180px; color:black;">產品名稱</td>';
	                    string+='<td id="workjs_place" title="位置" align="center" style="width:100px; color:black;">位置</td>';
	                    string+='<td id="workjs_img" title="形狀" align="center" style="width:170px; color:black;">形狀</td>';
	                    string+='<td id="workjs_lengthb" title="長度" align="center" style="width:100px; color:black;">長度</td>';
	                    string+='<td id="workjs_mount" title="數量" align="center" style="width:100px; color:black;">數量</td>';
	                    string+='<td id="workjs_weight" title="重量" align="center" style="width:80px; color:black;">重量</td>';
	                    string+='<td id="workjs_mechno1" title="機台1" align="center" style="width:130px; color:black;display:none;">機台編號1</td>';
	                    string+='<td id="workjs_mechno2" title="機台2" align="center" style="width:130px; color:black;display:none;">機台編號2</td>';
	                    string+='<td id="workjs_mechno3" title="機台3" align="center" style="width:130px; color:black;display:none;">機台編號3</td>';
	                    string+='<td id="workjs_mechno4" title="機台4" align="center" style="width:130px; color:black;display:none;">機台編號4</td>';
	                    string+='<td id="workjs_mechno5" title="機台5" align="center" style="width:130px; color:black;display:none;">機台編號5</td>';
	                    string+='<td id="workjs_mech1" title="機台1" align="center" style="width:130px; color:black;">機台1</td>';
	                    string+='<td id="workjs_mech2" title="機台2" align="center" style="width:130px; color:black;">機台2</td>';
	                    string+='<td id="workjs_mech3" title="機台3" align="center" style="width:130px; color:black;">機台3</td>';
	                    string+='<td id="workjs_mech4" title="機台4" align="center" style="width:130px; color:black;">機台4</td>';
	                    string+='<td id="workjs_mech5" title="機台5" align="center" style="width:130px; color:black;">機台5</td>';
	                    string+='<td id="workjs_memo" title="備註" align="center" style="width:200px; color:black;">備註</td>';
	                    string+='<td id="workjs_noa" align="center" style="width:70px; color:black;display:none;">noa</td>';
	                    string+='<td id="workjs_noq" align="center" style="width:70px; color:black;display:none;">no2</td>';
	                    string+='</tr>';
	                    
	                    var t_color = ['DarkBlue','DarkRed'];
	                    var workvs_uno_where=' 1=0 ';
	                    for(var i=0;i<workjs.length;i++){
	                        string+='<tr id="workjs_tr'+i+'">';
	                        string+='<td style="text-align: center; font-weight: bolder; color:black;">'+(i+1)+'</td>';
	                        string+='<td id="workjs_productno'+i+'" style="text-align: center;color:'+t_color[i%t_color.length]+'">'+workjs[i].productno+'</td>';
	                        string+='<td id="workjs_product'+i+'" style="text-align: center;color:'+t_color[i%t_color.length]+'">'+workjs[i].product+'</td>';
	                        string+='<td id="workjs_place'+i+'" style="text-align: center;color:'+t_color[i%t_color.length]+'">'+workjs[i].place+'</td>';
	                        string+='<td id="workjs_img'+i+'" style="text-align: center;color:'+t_color[i%t_color.length]+'"><img src="'+'..\\htm\\htm\\img\\workj' + workjs[i].noa+'-'+workjs[i].noq+'.png?'+(new Date().Format("yyyy-MM-dd hh:mm:ss"))+'" width="170px"></td>';
	                        string+='<td id="workjs_lengthb'+i+'" style="text-align: center;color:'+t_color[i%t_color.length]+'">'+workjs[i].lengthb+'</td>';
	                        string+='<td id="workjs_mount'+i+'" style="text-align: center;color:'+t_color[i%t_color.length]+'">'+workjs[i].mount+'</td>';
	                        string+='<td id="workjs_weight'+i+'" style="text-align: center;color:'+t_color[i%t_color.length]+'">'+workjs[i].weight+'</td>';
	                        string+='<td id="workjs_mechno1'+i+'" style="text-align: center;color:'+t_color[i%t_color.length]+';display:none;">'+workjs[i].mech1+'</td>';
	                        string+='<td id="workjs_mechno2'+i+'" style="text-align: center;color:'+t_color[i%t_color.length]+';display:none;">'+workjs[i].mech2+'</td>';
	                        string+='<td id="workjs_mechno3'+i+'" style="text-align: center;color:'+t_color[i%t_color.length]+';display:none;">'+workjs[i].mech3+'</td>';
	                        string+='<td id="workjs_mechno4'+i+'" style="text-align: center;color:'+t_color[i%t_color.length]+';display:none;">'+workjs[i].mech4+'</td>';
	                        string+='<td id="workjs_mechno5'+i+'" style="text-align: center;color:'+t_color[i%t_color.length]+';display:none;">'+workjs[i].mech5+'</td>';
	                        string+='<td id="workjs_mech1'+i+'" style="text-align: center;color:'+t_color[i%t_color.length]+'"></td>';
	                        string+='<td id="workjs_mech2'+i+'" style="text-align: center;color:'+t_color[i%t_color.length]+'"></td>';
	                        string+='<td id="workjs_mech3'+i+'" style="text-align: center;color:'+t_color[i%t_color.length]+'"></td>';
	                        string+='<td id="workjs_mech4'+i+'" style="text-align: center;color:'+t_color[i%t_color.length]+'"></td>';
	                        string+='<td id="workjs_mech5'+i+'" style="text-align: center;color:'+t_color[i%t_color.length]+'"></td>';
	                        string+='<td id="workjs_memo'+i+'" style="text-align: center;color:'+t_color[i%t_color.length]+'">'+workjs[i].memo+'</td>';
	                        string+='<td id="workjs_noa'+i+'" style="text-align: center;color:'+t_color[i%t_color.length]+';display:none;">'+workjs[i].noa+'</td>';
	                        string+='<td id="workjs_noq'+i+'" style="text-align: center;color:'+t_color[i%t_color.length]+';display:none;">'+workjs[i].noq+'</td>';
	                        string+='</tr>';
	                        
	                        //workvs_uno_where=workvs_uno_where+(workvs_uno_where.length>0?' or ':'')+" charindex('"+workjs[i].noa+'-'+workjs[i].noq+"',uno)>0 ";
	                    }
	                    string+='</table>';
	                    
	                    $('#workjs').html(string);
	                    
	                    //讀取機台的名稱
	                    var t_where="where=^^ 1=1 ^^";
						q_gt('mech', t_where, 0, 0, 0,'workjs_mech', r_accy);
						
						//讀取workvs的資料
						if (workj[0] != undefined){
		                    var t_where="where=^^ uno like '"+workj[0].noa+"%' ^^";
							q_gt('workvs', t_where, 0, 0, 0,'workjs_workvs', r_accy);
						}
						
						break;	
					case 'workjs_mech':
						var as = _q_appendData("mech", "", true);
						for(var i=0;i<workjs_count;i++){
							for(var k=1;k<=5;k++){
								$('#workjs_mech'+k+i).text($('#workjs_mechno'+k+i).text());
								for(var j=0;j<as.length;j++){
									if($('#workjs_mechno'+k+i).text() == as[j].noa){
										$('#workjs_mech'+k+i).text(as[j].mech);
										break;
									}
								}
							}
						}
						break;
					case 'workjs_workvs':
						var as = _q_appendData("workvs", "", true);
						for(var i=0;i<workjs_count;i++){
							for(var k=1;k<=5;k++){
								var t_lengthb=0,t_mount=0,t_weight=0;
								for(var j=0;j<as.length;j++){
									if(as[j].uno.indexOf($('#workjs_noa'+i).text()+'-'+$('#workjs_noq'+i).text()+'-'+k)>-1){
										t_lengthb=q_add(t_lengthb,dec(as[j].lengthb));
										t_mount=q_add(t_mount,dec(as[j].mount));
										t_weight=q_add(t_weight,dec(as[j].weight));
									}
								}
								/*if(t_lengthb>0 || t_mount>0 || t_weight>0){
									var t_tmp=$('#workjs_mech'+k+i).text();
									$('#workjs_mech'+k+i).text(t_tmp+"\n"+t_lengthb+"/"+t_mount+"/"+t_weight);
								}*/
								if(t_mount>0){
									var t_tmp=$('#workjs_mech'+k+i).text();
									$('#workjs_mech'+k+i).html(t_tmp+" <br /> 完成數量："+t_mount);
									
									if(t_mount==dec($('#workjs_mount'+i).text())){
										$('#workjs_mech'+k+i).css('background-color','gold');
									}
								}
							}
						}
						break;
					case 'check_vcce':
						var as = _q_appendData("view_vcces", "", true);
						if(as.length>0){
							var t_where = "noa='" + chk_vcce + "'";
                   			q_box("z_drvp.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, '', "95%", "95%", q_getMsg('popPrint'));
						}else{
							alert('請先【轉派車單】，在列印!!');
						}
						break;
					case 'loadcaddr':
                        var GG = _q_appendData("view_orde", "", true);
                        if (GG[0] != undefined){
                            orde.curCaddr.push({addrno:'',addr:''});
                        }
                        break;
                    case 'aaa':
                        var GG = _q_appendData("view_orde", "", true);
                        if (GG[0] != undefined)
                            orde.init(GG);
                        else{
                            Unlock();
                            alert('無資料。');
                        }
                        break;
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
					default:
                        if(t_name.substring(0,15)=='getordeAccy'){
                            var t_noa = t_name.split('_')[1];
                            var GG = _q_appendData("view_orde", "", true);
                            if(GG[0]!=undefined){
                                q_box("orde.aspx?;;;noa='" + t_noa + "';"+GG[0].accy, 'orde', "95%", "95%", q_getMsg("poporde"));
                            }else{
                                alert('查無訂單。');
                            }
                        }
                        break;
				}
			}
			
			var enda_page=1;
			function q_funcPost(t_func, result) {
                switch(t_func) {
                	case 'qtxt.query.drv2vcce':
                		alert("已轉至派車單!!");
						var t_where = "1=1 and isnull(enda,'0')!='1' and isnull(cancel,'0')!='1' ";
	                    t_where="where=^^"+t_where+"^^";
	                    Lock();
						q_gt('view_orde', t_where, 0, 0, 0,'aaa', r_accy);
                	break;
                	case 'qtxt.query.ordeenda':
                		var t_where = "1=1 and isnull(enda,'0')!='1' and isnull(cancel,'0')!='1' ";
	                    t_where="where=^^"+t_where+"^^";
	                    Lock();
						q_gt('view_orde', t_where, 0, 0, 0,'aaa', r_accy);
                	break;
                }
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
				overflow: hidden;
			}
			.dview {
				float: left;
				width: 98%;
			}
			.tview {
				margin: 0;
				padding: 2px;
				border: 1px black double;
				border-spacing: 0;
				font-size: medium;
				background-color: #FFFF66;
				color: blue;
			}
			.tview td {
				padding: 2px;
				text-align: center;
				border: 1px black solid;
			}
			.dbbm {
				float: left;
				width: 98%;
				margin: -1px;
				border: 1px black solid;
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
				width: 2%;
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
				width: 98%;
				float: left;
			}
			.txt.c2 {
				width: 38%;
				float: left;
			}
			.txt.c3 {
				width: 60%;
				float: left;
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
			.tbbm select {
				border-width: 1px;
				padding: 0px;
				margin: -1px;
				font-size: medium;
			}

			input[type="text"], input[type="button"] {
				font-size: medium;
			}
			.dbbs .tbbs {
				margin: 0;
				padding: 2px;
				border: 2px lightgrey double;
				border-spacing: 1px;
				border-collapse: collapse;
				font-size: medium;
				color: blue;
				background: #cad3ff;
				width: 100%;
			}
			.dbbs .tbbs tr {
				height: 35px;
			}
			.dbbs .tbbs tr td {
				text-align: center;
				border: 2px lightgrey double;
			}
			#orde_table {
                border: 5px solid gray;
                font-size: medium;
                background-color: white;
            }
            #orde_table tr {
                height: 30px;
            }
            #orde_table td {
                padding: 2px;
                text-align: center;
                border-width: 0px;
                background-color: pink;
                color: blue;
            }
            #orde_header td:hover{
                background : yellow;
                cursor : pointer;
            }
            
            #ordes_table {
                border: 5px solid gray;
                font-size: medium;
                background-color: white;
            }
            #ordes_table tr {
                height: 30px;
            }
            #ordes_table td {
                padding: 2px;
                text-align: center;
                border-width: 0px;
                background-color: bisque;
                color: blue;
            }
            
            #workjs_table {
                border: 5px solid gray;
                font-size: medium;
                background-color: white;
            }
            #workjs_table tr {
                height: 30px;
            }
            #workjs_table td {
                padding: 2px;
                text-align: center;
                border-width: 0px;
                background-color: darkseagreen;
                color: blue;
            }
		</style>
	</head>
	<body>
		<div id='q_menu'> </div>
		<div id='q_acDiv'> </div>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type='button' id='btnAuthority' name='btnAuthority' style='font-size:16px;' value='權限'/>
		<a id="lblCarno" class="lbl"> </a>
		<input id="textCarno"  type="text" class="txt" style="width: 100px;"/>
		<a id="lblDriver" class="lbl"> </a>
		<input id="textDriverno"  type="text" class="txt " style="width: 100px;"/>
		<input id="textDriver"  type="text" class="txt" style="width: 100px;" disabled="disabled"/>
		<input type='button' id='btnVcce' style='font-size:16px;'/>
		<input type='button' id='btnPrints' style='font-size:16px;'/>
		<input type='button' id='btnCancels' style='font-size:16px;'/>
		<!--<input type='button' id='btnStore' style='font-size:16px;'/>-->
		<div id="div_stk" style="position:absolute; top:300px; left:400px; display:none; width:400px; background-color: #CDFFCE; border: 5px solid gray;">
			<table id="table_stk" style="width:100%;" border="1" cellpadding='2'  cellspacing='0'>
				<tr>
					<td style="background-color: #f8d463;" align="center">產品編號</td>
					<td style="background-color: #f8d463;" colspan="3" id='stk_productno'> </td>
				</tr>
				<tr>
					<td style="background-color: #f8d463;" align="center">產品名稱</td>
					<td style="background-color: #f8d463;" colspan="3" id='stk_product'> </td>
				</tr>
				<tr id='stk_top'>
					<td align="center" style="width: 20%;">倉庫編號</td>
					<td align="center" style="width: 30%;">倉庫名稱</td>
					<td align="center" style="width: 25%;">庫存數量</td>
					<td align="center" style="width: 25%;">庫存重量</td>
				</tr>
				<tr id='stk_close'>
					<td align="center" colspan='4'>
						<input id="btnClose_div_stk" type="button" value="關閉視窗">
					</td>
				</tr>
			</table>
		</div>
		<div id="orde" style="float:left;width:1260px;"> </div> 
		<div id="orde_control" style="width:1200px;"> </div> 
		<div id="ordes" style="float:left;width:1260px;"> </div> 
		<!--<input type='button' id='btnEnda' style='font-size:16px;float: left;'/>-->
		<div id="workjs" style="float:left;width:1260px;"> </div> 
	</body>
</html>