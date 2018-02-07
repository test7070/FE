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
			this.errorHandler = null;
			q_tables = 't';
			var q_name = "cub";
			var q_readonly = ['txtNoa','txtC1','txtWorker','txtWorker2'];
			var q_readonlys = ['txtDate2', 'txtOrdeno', 'txtNo2','txtProduct','txtScolor','txtProcess'];
			var q_readonlyt = [];
			var bbmNum = [['txtM2',10,0,1],['txtM3',10,0,1],['txtM4',10,0,1],['txtM5',10,0,1],['txtM6',10,0,1],['txtM7',10,0,1],['txtM8',10,0,1]
			,['txtBdime',10,0,1],['txtEdime',10,0,1],['txtOdime',10,0,1],['txtC1',15,0,1],['txtWaste',15,0,1],['txtMo',15,1,1],['txtLevel',2,0,1],['txtIdime',10,0,1]];
			var bbsNum = [['txtMount',15,0,1],['txtWeight',15,2,1],['txtLengthb',10,0,1],['txtW01',10,2,1],['txtW02',10,2,1],['txtW03',10,0,1]];//,['txtW04',10,2,1]
			var bbtNum = [['txtGmount',10,0,1],['txtGweight',10,2,1],['txtLengthc',10,0,1]];
			var bbmMask = [];
			var bbsMask = [];
			var bbtMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			q_desc = 1;
			brwCount2 = 12;
			aPop = new Array(
				['txtProductno_', 'btnProduct_', 'ucaucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucaucc_b.aspx'],
				['txtProductno__', 'btnProduct__', 'ucaucc', 'noa,product,unit', 'txtProductno__,txtProduct__,txtUnit__', 'ucaucc_b.aspx'],
				['txtStoreno__', 'btnStore__', 'store', 'noa,store', 'txtStoreno__,txtStore__', 'store_b.aspx'],
				['txtUno__', '', 'view_uccb', 'uno,productno,product,unit,mount,weight,storeno', ',txtUno__,txtProductno__,txtProduct__,txtUnit__,txtGmount__,txtGweight__,txtStoreno__', 'store_b.aspx'],
				['txtProcessno_', '', 'mech', 'noa,mech', 'txtProcessno_,txtProcess_', 'mech_b.aspx'],
				['txtTggno', 'lblStoreno', 'store', 'noa,store', 'txtTggno,txtTgg', 'store_b.aspx']
			);

			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'noq'];
				bbtKey = ['noa', 'noq'];
				q_brwCount();
				q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
			});

			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainForm(0);
			}

			function sum() {
				var t_c1=0;
				for (var j = 0; j < q_bbtCount; j++) {
					var t_lengthc = dec($('#txtLengthc__' + j).val());
					var t_gmount = dec($('#txtGmount__' + j).val());
					t_c1=q_add(t_c1,q_mul(t_lengthc,t_gmount));
				}
				
				$('#txtC1').val(t_c1);
			}
			
			var safeas=[];//低於安全庫存量
			var safehas=[];//高於安全庫存量
			var t_sort=[];
			function mainPost() {
				q_getFormat();
				bbmMask = [['txtDatea', r_picd], ['txtBdate', r_picd], ['txtEdate', r_picd]];
				bbsMask = [['txtDate2', r_picd], ['txtDatea', r_picd]];
				q_mask(bbmMask);
				
				q_gt('mech', "where=^^1=1^^" , 0, 0, 0, "getmech",r_accy,1); //號數
				var as = _q_appendData("mech", "", true);
				var t_item = "";
				if (as[0] != undefined) {
					for ( i = 0; i < as.length; i++) {
						t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].mech;
					}
				}
				if(t_item.length>0)
					q_cmbParse("cmbMechno", t_item);
				else
					q_cmbParse("cmbMechno", "01@剪台,02@火切,12@D10盤圓,13@D13盤圓,20@續接裁剪");
				q_cmbParse("cmbProcess", "2@最少排刀,1@最低損耗");
				
				document.title='鋼筋裁剪單';
				q_gt('add5', "where=^^1=1^^" , 0, 0, 0, "getadd5",r_accy,1); //號數
				var as = _q_appendData("add5", "", true);
				as.sort(function(a, b){if (dec(a.typea) > dec(b.typea)) {return 1;}if (dec(a.typea) < dec(b.typea)) {return -1;}});
				var t_item = " @ ";
				if (as[0] != undefined) {
					for ( i = 0; i < as.length; i++) {
						t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].typea + '@' + as[i].typea;
					}
				}
				q_cmbParse("cmbM1", t_item);
				
				q_gt('addrcase', "where=^^1=1^^", 0, 0, 0, "getaddrcase",r_accy,1); //材質
				var as = _q_appendData("addrcase", "", true);
				as.sort(function(a, b){if (a.addr > b.addr) {return 1;}if (a.addr < b.addr) {return -1;}});
				t_item = " @ ";
				if (as[0] != undefined) {
					for ( i = 0; i < as.length; i++) {
						t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].addr + '@' + as[i].addr;
					}
				}
				q_cmbParse("cmbSpec", t_item);
				q_gt('adsize', "where=^^1=1 and mon!='' ^^", 0, 0, 0, "getadsize",r_accy,1); //長度
				var as = _q_appendData("adsize", "", true);
				as.sort(function(a, b){if (a.mon > b.mon) {return 1;}if (a.mon < b.mon) {return -1;}});
				t_item = "";
				if (as[0] != undefined) {
					for ( i = 0; i < as.length; i++) {
						t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].mon + '@' + as[i].mon;
					}
				}
				q_cmbParse("combStatus", t_item);
				
				$('#btnStk').click(function() {
					q_box("z_uccfe.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";", 'z_uccfe', "95%", "95%", $('#btnStk').val());
				});
				
				//讀取低於安全庫存量
				var t_htmlsafe="<tr><td style='width:90px;'>材質</td><td style='width:60px;'>號數</td><td style='width:70px;'>長度</td><td style='width:100px;'>庫存</td><td style='width:100px;'>安全存量</td></tr>";
				$('#tstksafe').html('');
				q_func('qtxt.query.safemountfe', 'cub.txt,safemountfe,' + encodeURI(q_date())+';'+encodeURI('#non')+';'+encodeURI('#non')+';'+encodeURI('0'),r_accy,1);
				var as = _q_appendData("tmp0", "", true, true);
				if (as[0] != undefined) {
					for (var j=0;j<as.length;j++){
						var tproduct=as[j].product;
						var tlen=round(dec(replaceAll(tproduct.split('#*')[1],'M',''))*100,0);
						var tspec='';
						var tsize='';
						if(tproduct.indexOf('螺栓')>-1){
							tspec='SD420W';
							tsize=replaceAll(replaceAll(tproduct.split('#')[0]+'#','基礎螺栓',''),'抗震專利','');
						}else{ //鋼筋
							tspec=tproduct.substr(tproduct.indexOf('S'),tproduct.indexOf(' ')-tproduct.indexOf('S'));
							tsize=tproduct.split(' ')[1].split('*')[0];
						}
						var tmount=round(as[j].mount,0);
						var tsafe=round(as[j].safemount,0);
						
						t_htmlsafe+="<tr><td>"+tspec+"</td><td>"+tsize+"</td><td>"+tlen+"</td><td style='text-align: right;'>"+tmount+"</td><td style='text-align: right;'>"+tsafe+"</td></tr>";
					}
				}
				if(as.length>0){
					$('#tstksafe').html(t_htmlsafe);
					$('#btnSafefe').show();
				}
					
				$('#btnSafefe').click(function() {
					$('#dstksafe').toggle();
				});
				
				$('#btnWorkjImport').click(function() {
					var t_workjno=$('#txtMemo2').val();
					var t_mech=$('#cmbMechno').val();
					var t_bdate = trim($('#txtBdate').val());
					var t_edate = trim($('#txtEdate').val());
					var t_spec = $('#cmbSpec').val();
					var t_m1 = trim($('#cmbM1').val());
					//外調定尺不用裁剪
					//var t_where = " 1=1 and (mech1='"+t_mech+"' or mech2='"+t_mech+"' or mech3='"+t_mech+"' or mech4='"+t_mech+"' or mech5='"+t_mech+"')";
					var t_where = " 1=1";
					if(t_workjno.length>0){
						t_where+=" and charindex(a.noa,'"+t_workjno+"')>0 ";
					}
					t_bdate = (emp(t_bdate) ? '' : t_bdate);
					t_edate = (emp(t_edate) ? r_picd : t_edate);
					t_where += " and (a.odate between '" + t_bdate + "' and '" + t_edate + "') ";
					if(t_spec.length>0){
						var specwhere='';
						//106/08/30 判斷有沒有SD280W 字串問題
						var is280w=false;
						for (var i=0;i<t_spec.length;i++){
							if(trim(t_spec[i])=='SD280W'){
								is280w=true;
								break;
							}
						}
						
						for (var i=0;i<t_spec.length;i++){
							if(trim(t_spec[i])!=''){
								specwhere = specwhere+" or (case when b.product like '%基礎螺栓%' then 'SD420W' else b.product end) like '%" + t_spec[i] + "%'";
							}
						}
						if (specwhere.length>0){
							specwhere='1=0'+specwhere;
							if(!is280w)
								t_where += " and ("+specwhere+") and b.product not like '%SD280W%' ";
							else
								t_where += " and ("+specwhere+") ";
						}
					}
					if(t_m1.length>0){
						t_where += " and (b.product like '%" + t_m1 + "%') ";
					}
					//107/01/15
					t_where+=" and isnull(b.mech1,'')='"+t_mech+"'";
					
					//107/01/08
					//t_where+=" and b.mech1 not between '04' and '06A'";
					//t_where+=" and b.mech2 not between '04' and '06A'";
					//t_where+=" and b.mech3 not between '04' and '06A'";
					//t_where+=" and b.mech4 not between '04' and '06A'";
					//t_where+=" and b.mech5 not between '04' and '06A'";
					
					if(q_cur==1 || q_cur==2)
						q_box("workjsfe_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'workjsfe_b', "95%", "95%", q_getMsg('popOrde'));
				});
				
				$('#btnCubu').click(function() {
					if (q_cur == 0 || q_cur==4) {
						if(!emp(trim($('#txtNoa').val()))){
							var t_where = "noa='" + trim($('#txtNoa').val()) + "'";
							q_box("cubufe_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where + ";"+r_accy, 'cubu', "95%", "95%", q_getMsg('popCubu'));
						}
					}
				});
				
				$('#btnUcccstk').click(function() {
					if(!(q_cur==1 || q_cur==2)){
						return;
					}
					//106/04/20 每個圖形加入可減少的誤差offlength>W03
					//當天同一個長度 可多做0.3%數(千分之3)M09
					//根據標籤拆或不同品項 裁剪內容拆分
					//---------------------------------------------------------------
					Lock(1);
					//107/01/26-抓取安全存量-------------------------------------
					safeas=[];
					safehas=[];
					var t_specsize=[];
					var t_cutsheet=$('#combStatus').val();//可裁剪的板料長度
					var maxcutsheet=0;//最大板料長度
					if($('#combStatus').find("option:selected").text().length==0){
						t_cutsheet='12';
						t_cutsheet=t_cutsheet.split(',');
					}
					for (var i = 0; i < t_cutsheet.length; i++) {
						if(maxcutsheet<dec(t_cutsheet[i])*100){
							maxcutsheet=dec(t_cutsheet[i])*100;
						}
					}
					for (var i = 0; i < q_bbsCount; i++) {
						if(!emp($('#txtProductno_'+i).val()) && !emp($('#txtProduct_'+i).val()) 
						&& ($('#txtProduct_'+i).val().indexOf('鋼筋')>-1 || $('#txtProduct_'+i).val().indexOf('螺栓')>-1)
						&& dec($('#txtLengthb_'+i).val())<=maxcutsheet){
							var tproduct=$('#txtProduct_'+i).val();
							//材質號數長度
							var tspec='';
							var tsize='';
							if(tproduct.indexOf('螺栓')>-1){
								tspec='SD420W';
								tsize=replaceAll(replaceAll(tproduct.split('#')[0]+'#','基礎螺栓',''),'抗震專利','');
							}else{ //鋼筋
								tspec=tproduct.substr(tproduct.indexOf('S'),tproduct.indexOf(' ')-tproduct.indexOf('S'));
								tsize=tproduct.split(' ')[1].split('*')[0];
							}
							
							var t_j=-1;
							for (var j=0;j<t_specsize.length;j++){
								if(t_specsize[j].spec==tspec && t_specsize[j].size==tsize){
									t_j=j;
									break;
								}
							}
							
							if(t_j<0){
								t_specsize.push({
									'spec':tspec,
									'size':tsize
								});
							}
							
						}
					}
					
					for (var i=0;i<t_specsize.length;i++){
						var tspec1=t_specsize[i].spec;
						var tsize1=t_specsize[i].size;
						//低於安全庫存
						q_func('qtxt.query.safemountfe', 'cub.txt,safemountfe,' + encodeURI(q_date())+';'+encodeURI(tspec1+' ')+';'+encodeURI(tsize1)+';'+encodeURI('0'),r_accy,1);
						var as = _q_appendData("tmp0", "", true, true);
						if (as[0] != undefined) {
							for (var j=0;j<as.length;j++){
								var tlen=round(dec(replaceAll(as[j].product.split('#*')[1],'M',''))*100,0);
								as[j].lengthb=tlen;
								as[j].spec=tspec1;
								as[j].size=tsize1;
								
								if(dec(as[j].addsafe)==0){
									as.splice(j, 1);
									j--;
								}
							}
							
							safeas=safeas.concat(as);
						}
						//高於安全庫存
						if(dec($('#txtIdime').val())>0){
							q_func('qtxt.query.safemountfe', 'cub.txt,safemountfe,' + encodeURI(q_date())+';'+encodeURI(tspec1+' ')+';'+encodeURI(tsize1)+';'+encodeURI('1'),r_accy,1);
							var as = _q_appendData("tmp0", "", true, true);
							if (as[0] != undefined) {
								for (var j=0;j<as.length;j++){
									var tlen=round(dec(replaceAll(as[j].product.split('#*')[1],'M',''))*100,0);
									as[j].lengthb=tlen;
									as[j].spec=tspec1;
									as[j].size=tsize1;
									
									if(dec(as[j].safemount)==0){
										as.splice(j, 1);
										j--;
									}else{
										var tsmount=round(dec(as[j].safemount)*dec($('#txtIdime').val())/100,0);
										//庫存量-安全庫存量>安全%量 || 無訂單尚未裁剪
										if(as[j].mount-dec(as[j].safemount)>=tsmount || dec(as[j].notv)==0){
											as[j].smount=tsmount;
										}else{
											as[j].smount=round(as[j].mount-dec(as[j].safemount),0);
										}
									}
									
								}
								
								safehas=safehas.concat(as);
							}
						}
					}
					//---------------------------------------------------
					
					
					getp1 (); //最長 +短
					console.log('getp1');
					getp2 (); //數量多
					console.log('getp2');
					getp3 (); //最長 數量相同
					console.log('getp3');
					getp4 (); //數量少
					console.log('getp4');
					/*getp5 (); //最長 +長
					console.log('getp5');
					getp6 (); //最長 數量相同 延長版料先用 多裁組合量直到 最大量和當所需訂單=0
					console.log('getp6');*/
					
					//將板料寫回bbt
					//先清空bbt
					for (var i = 0; i < q_bbtCount; i++) {
						$('#btnMinut__'+i).click();
					}
					
					var p1c1=0,p1m1=0,pp1=$.extend(true,[], t_p1getucc);
					var p2c1=0,p2m1=0,pp2=$.extend(true,[], t_p2getucc);
					var p3c1=0,p3m1=0,pp3=$.extend(true,[], t_p3getucc);
					var p4c1=0,p4m1=0,pp4=$.extend(true,[], t_p4getucc);
					//pp1--------------------------------------------------------
					for (var i = 0; i < pp1.length; i++) {
						pp1[i].cutlen.sort(function(a, b) { if(dec(a) > dec(b)) {return 1;} if (dec(a) < dec(b)) {return -1;} return 0;})
						
						var t_lens='',t_mounts=0,t_totallen=0;
						for (var j = 0; j < pp1[i].cutlen.length; j++) {
							if(pp1[i].cutlen[j].toString()!='' && pp1[i].cutlen[j].toString()!='0'){
								if(t_lens!='' && t_lens!=pp1[i].cutlen[j]){
									//非損耗
									if(!(t_lens==pp1[i].wlengthb.toString() && (dec(t_lens)<=pp1[i].lengthb*dec($('#txtMo').val()/100) || dec(t_lens)<=dec($('#txtWaste').val())))){
										if(t_lens==pp1[i].wlengthb.toString()){
											pp1[i].wlengthb=0;
										}else
										t_totallen=q_add(t_totallen,q_mul(dec(t_lens),t_mounts));
									}
									t_mounts=0;
								}
								t_mounts=t_mounts+1;
								t_lens=pp1[i].cutlen[j].toString();
							}
						}
						//含最後一筆
						if(dec(t_lens)>0){
							if(!(t_lens==pp1[i].wlengthb.toString() && (dec(t_lens)<=pp1[i].lengthb*dec($('#txtMo').val()/100) || dec(t_lens)<=dec($('#txtWaste').val())))){
								if(t_lens==pp1[i].wlengthb.toString()){
									pp1[i].wlengthb=0;
								}
								t_totallen=q_add(t_totallen,q_mul(dec(t_lens),t_mounts));
							}
						}
					}
					var t_tpp=[];
					for (var i = 0; i < pp1.length; i++) {
						p1c1=q_add(dec(p1c1),dec(pp1[i].wlengthb));
						var t_j=-1;
						for(var j=0;j<t_tpp.length;j++){
							if(t_tpp[j]==pp1[i].cutlen.toString()){
								t_j=j
								break;
							}
						}
						if(t_j==-1){
							t_tpp.push(pp1[i].cutlen.toString());
						}
					}
					p1m1=t_tpp.length;
					//pp2--------------------------------------------------------
					for (var i = 0; i < pp2.length; i++) {
						pp2[i].cutlen.sort(function(a, b) { if(dec(a) > dec(b)) {return 1;} if (dec(a) < dec(b)) {return -1;} return 0;})
						
						var t_lens='',t_mounts=0,t_totallen=0;
						for (var j = 0; j < pp2[i].cutlen.length; j++) {
							if(pp2[i].cutlen[j].toString()!='' && pp2[i].cutlen[j].toString()!='0'){
								if(t_lens!='' && t_lens!=pp2[i].cutlen[j]){
									//非損耗
									if(!(t_lens==pp2[i].wlengthb.toString() && (dec(t_lens)<=pp2[i].lengthb*dec($('#txtMo').val()/100) || dec(t_lens)<=dec($('#txtWaste').val())))){
										if(t_lens==pp2[i].wlengthb.toString()){
											pp2[i].wlengthb=0;
										}else
										t_totallen=q_add(t_totallen,q_mul(dec(t_lens),t_mounts));
									}
									t_mounts=0;
								}
								t_mounts=t_mounts+1;
								t_lens=pp2[i].cutlen[j].toString();
							}
						}
						//含最後一筆
						if(dec(t_lens)>0){
							if(!(t_lens==pp2[i].wlengthb.toString() && (dec(t_lens)<=pp2[i].lengthb*dec($('#txtMo').val()/100) || dec(t_lens)<=dec($('#txtWaste').val())))){
								if(t_lens==pp2[i].wlengthb.toString()){
									pp2[i].wlengthb=0;
								}
								t_totallen=q_add(t_totallen,q_mul(dec(t_lens),t_mounts));
							}
						}
					}
					
					var t_tpp=[];
					for (var i = 0; i < pp2.length; i++) {
						p2c1=q_add(dec(p2c1),dec(pp2[i].wlengthb));
						var t_j=-1;
						for(var j=0;j<t_tpp.length;j++){
							if(t_tpp[j]==pp2[i].cutlen.toString()){
								t_j=j
								break;
							}
						}
						if(t_j==-1){
							t_tpp.push(pp2[i].cutlen.toString());
						}
					}
					p2m1=t_tpp.length;
					//pp3--------------------------------------------------------
					for (var i = 0; i < pp3.length; i++) {
						pp3[i].cutlen.sort(function(a, b) { if(dec(a) > dec(b)) {return 1;} if (dec(a) < dec(b)) {return -1;} return 0;})
						
						var t_lens='',t_mounts=0,t_totallen=0;
						for (var j = 0; j < pp3[i].cutlen.length; j++) {
							if(pp3[i].cutlen[j].toString()!='' && pp3[i].cutlen[j].toString()!='0'){
								if(t_lens!='' && t_lens!=pp3[i].cutlen[j]){
									//非損耗
									if(!(t_lens==pp3[i].wlengthb.toString() && (dec(t_lens)<=pp3[i].lengthb*dec($('#txtMo').val()/100) || dec(t_lens)<=dec($('#txtWaste').val())))){
										if(t_lens==pp3[i].wlengthb.toString()){
											pp3[i].wlengthb=0;
										}else
										t_totallen=q_add(t_totallen,q_mul(dec(t_lens),t_mounts));
									}
									t_mounts=0;
								}
								t_mounts=t_mounts+1;
								t_lens=pp3[i].cutlen[j].toString();
							}
						}
						//含最後一筆
						if(dec(t_lens)>0){
							if(!(t_lens==pp3[i].wlengthb.toString() && (dec(t_lens)<=pp3[i].lengthb*dec($('#txtMo').val()/100) || dec(t_lens)<=dec($('#txtWaste').val())))){
								if(t_lens==pp3[i].wlengthb.toString()){
									pp3[i].wlengthb=0;
								}
								t_totallen=q_add(t_totallen,q_mul(dec(t_lens),t_mounts));
							}
						}
					}
					
					var t_tpp=[];
					for (var i = 0; i < pp3.length; i++) {
						p3c1=q_add(dec(p3c1),dec(pp3[i].wlengthb));
						var t_j=-1;
						for(var j=0;j<t_tpp.length;j++){
							if(t_tpp[j]==pp3[i].cutlen.toString()){
								t_j=j
								break;
							}
						}
						if(t_j==-1){
							t_tpp.push(pp3[i].cutlen.toString());
						}
					}
					p3m1=t_tpp.length;
					//pp4--------------------------------------------------------
					for (var i = 0; i < pp4.length; i++) {
						pp4[i].cutlen.sort(function(a, b) { if(dec(a) > dec(b)) {return 1;} if (dec(a) < dec(b)) {return -1;} return 0;})
						
						var t_lens='',t_mounts=0,t_totallen=0;
						for (var j = 0; j < pp4[i].cutlen.length; j++) {
							if(pp4[i].cutlen[j].toString()!='' && pp4[i].cutlen[j].toString()!='0'){
								if(t_lens!='' && t_lens!=pp4[i].cutlen[j]){
									//非損耗
									if(!(t_lens==pp4[i].wlengthb.toString() && (dec(t_lens)<=pp4[i].lengthb*dec($('#txtMo').val()/100) || dec(t_lens)<=dec($('#txtWaste').val())))){
										if(t_lens==pp4[i].wlengthb.toString()){
											pp4[i].wlengthb=0;
										}else
										t_totallen=q_add(t_totallen,q_mul(dec(t_lens),t_mounts));
									}
									t_mounts=0;
								}
								t_mounts=t_mounts+1;
								t_lens=pp4[i].cutlen[j].toString();
							}
						}
						//含最後一筆
						if(dec(t_lens)>0){
							if(!(t_lens==pp4[i].wlengthb.toString() && (dec(t_lens)<=pp4[i].lengthb*dec($('#txtMo').val()/100) || dec(t_lens)<=dec($('#txtWaste').val())))){
								if(t_lens==pp4[i].wlengthb.toString()){
									pp4[i].wlengthb=0;
								}
								t_totallen=q_add(t_totallen,q_mul(dec(t_lens),t_mounts));
							}
						}
					}
					
					var t_tpp=[];
					for (var i = 0; i < pp4.length; i++) {
						p4c1=q_add(dec(p4c1),dec(pp4[i].wlengthb));
						var t_j=-1;
						for(var j=0;j<t_tpp.length;j++){
							if(t_tpp[j]==pp4[i].cutlen.toString()){
								t_j=j
								break;
							}
						}
						if(t_j==-1){
							t_tpp.push(pp4[i].cutlen.toString());
						}
					}
					p4m1=t_tpp.length;
					//--------------------------------------------------------
					t_sort=[];
					t_sort.push({
						'selectd':'p1',//方法
						'c':p1c1, //損耗
						'm':p1m1 //換料
					});
					t_sort.push({
						'selectd':'p2',//方法
						'c':p2c1, //損耗
						'm':p2m1 //換料
					});
					t_sort.push({
						'selectd':'p3',//方法
						'c':p3c1, //損耗
						'm':p3m1 //換料
					});
					t_sort.push({
						'selectd':'p4',//方法
						'c':p4c1, //損耗
						'm':p4m1 //換料
					});
					
					var getucc=[];
					if($('#cmbProcess').val()=='1'){//最低損耗
						t_sort.sort(function(a, b) { if(dec(a.c) < dec(b.c)) {return -1;} if (dec(a.c) > dec(b.c)) {return 1;} if(dec(a.m) < dec(b.m)) {return -1;} if (dec(a.m) > dec(b.m)) {return 1;} return 0;})
					}else{//最低換料
						t_sort.sort(function(a, b) { if(dec(a.m) < dec(b.m)) {return -1;} if (dec(a.m) > dec(b.m)) {return 1;} if(dec(a.c) < dec(b.c)) {return -1;} if (dec(a.c) > dec(b.c)) {return 1;} return 0;})
					}
					switch(t_sort[0].selectd){
						case 'p1': getucc=$.extend(true,[], t_p1getucc); break;
						case 'p2': getucc=$.extend(true,[], t_p2getucc); break;
						case 'p3': getucc=$.extend(true,[], t_p3getucc); break;
						case 'p4': getucc=$.extend(true,[], t_p4getucc); break;
					}
					
					while(getucc.length>q_bbtCount){
						$('#btnPlut').click()
					}
					
					//取最小定尺尺寸
					var t_stlen=50;
					if(getucc[0]!= undefined){
						q_gt('adknife', "where=^^ style='"+getucc[0].size+"'^^", 0, 0, 0, "getadknife",r_accy,1);
						var as = _q_appendData("adknife", "", true);
						if(as[0]!= undefined){
							if(as[0].memo.length>0){
								t_stlen=dec(replaceAll(as[0].memo.split('/')[0],'cm',''));
								asknife=replaceAll(as[0].memo,'cm','').split('/');
							}
						}
						for(var j=0;j<asknife.length;j++){
							if(asknife[j]==''){
								asknife.splice(j, 1);
								j--;
							}else{
								asknife[j]=dec(asknife[j]);
							}
						}
					}
					
					var t_n=0,as_where=[];
					for (var i = 0; i < getucc.length; i++) {
						var t_weight=0;
						switch(getucc[i].size){
				            case '3#': t_weight=0.560; break;
				            case '4#': t_weight=0.994; break;
				            case '5#': t_weight=1.560; break;
				            case '6#': t_weight=2.250; break;
				            case '7#': t_weight=3.040; break;
				            case '8#': t_weight=3.980; break;
				            case '9#': t_weight=5.080; break;
				            case '10#': t_weight=6.390; break;
				            case '11#': t_weight=7.900; break;
				            case '12#': t_weight=9.570; break;
				            case '14#': t_weight=11.40; break;
				            case '16#': t_weight=15.50; break;
				            case '18#': t_weight=20.20; break;
						}
						
						//長度越長越後裁剪避免剪裁機限制長度
						getucc[i].cutlen.sort(function(a, b) { if(dec(a) > dec(b)) {return 1;} if (dec(a) < dec(b)) {return -1;} return 0;})
						//106/11/23 長度在前面 //107/01/29 功能還原之前方式
						//getucc[i].cutlen.sort(function(a, b) { if(dec(a) > dec(b)) {return -1;} if (dec(a) < dec(b)) {return 1;} return 0;})
							
						var t_lens='',t_mounts=0,t_memo2='',t_totallen=0,t_memo3='';
						for (var j = 0; j < getucc[i].cutlen.length; j++) {
							if(getucc[i].cutlen[j].toString()!='' && getucc[i].cutlen[j].toString()!='0'){
								if(t_lens!='' && t_lens!=getucc[i].cutlen[j]){
									var t_inlengthb=false;
									for (var k = 0; k < getucc[i].data.length; k++) {
										if(dec(t_lens)==getucc[i].data[k].lengthb){
											t_inlengthb=true;
											break;
										}
									}
									
									//非損耗
									if(!(t_lens==getucc[i].wlengthb.toString() && (dec(t_lens)<=getucc[i].lengthb*dec($('#txtMo').val()/100) || dec(t_lens)<=dec($('#txtWaste').val()))) 
										&& (dec(t_lens)>=t_stlen || t_inlengthb) ){
										if(t_lens==getucc[i].wlengthb.toString()){
											t_memo2=t_memo2+(t_memo2.length>0?'+':'')+t_lens+'*'+t_mounts+"(入庫)";
											getucc[i].wlengthb=0;
										}else
											t_memo2=t_memo2+(t_memo2.length>0?'+':'')+t_lens+'*'+t_mounts;
										t_totallen=q_add(t_totallen,q_mul(dec(t_lens),t_mounts));
									}
									t_mounts=0;
								}
								t_mounts=t_mounts+1;
								t_lens=getucc[i].cutlen[j].toString();
							}
						}
						//含最後一筆
						if(dec(t_lens)>0){
							if(!(t_lens==getucc[i].wlengthb.toString() && (dec(t_lens)<=getucc[i].lengthb*dec($('#txtMo').val()/100) || dec(t_lens)<=dec($('#txtWaste').val()))) && dec(t_lens)>=t_stlen){
								if(t_lens==getucc[i].wlengthb.toString()){
									t_memo2=t_memo2+(t_memo2.length>0?'+':'')+t_lens+'*'+t_mounts+"(入庫)";
									getucc[i].wlengthb=0;
								}else
									t_memo2=t_memo2+(t_memo2.length>0?'+':'')+t_lens+'*'+t_mounts;
								t_totallen=q_add(t_totallen,q_mul(dec(t_lens),t_mounts));
							}
						}
						
						t_memo2=t_memo2+"="+t_totallen.toString();
						
						//106/09/14----------------------------------
						for (var j = 0; j < getucc[i].noras.length; j++) {
							var ttn=dec(getucc[i].noras[j].nor)-1;
							if(!emp($('#txtComp_'+ttn).val())){
								t_memo3=t_memo3+(t_memo3.length>0?'\n':'')+'【'+$('#txtComp_'+ttn).val().substr(0,4)+'】-'+dec($('#txtLengthb_'+ttn).val())+'*'+getucc[i].noras[j].mount.toString();
							}else{
								t_memo3=t_memo3+(t_memo3.length>0?'\n':'')+'第'+getucc[i].noras[j].nor+'項'+'-'+dec($('#txtLengthb_'+ttn).val())+'*'+getucc[i].noras[j].mount.toString();
							}
						}
						//-------------------------------------------
						
						//取得產品資料
						var t_where="1=1 and product like '%"+getucc[i].spec+"%' ";
						t_where=t_where+" and product like '%"+getucc[i].size+"%' ";
						
						/*if(getucc[i].lengthb.toString().slice(-1)=='5'){ //106/03/22扣除多的5公分
							getucc[i].lengthb=dec(getucc[i].lengthb.toString().substr(0,getucc[i].lengthb.toString().length-1)+'0');
						}*/
						
						getucc[i].olengthb=getucc[i].lengthb;
						if(getucc[i].typea!='s')//非安全存量
							getucc[i].lengthb=dec(getucc[i].lengthb.toString().substr(0,getucc[i].lengthb.toString().length-2)+'00');
						
						t_where=t_where+" and (product like '%*"+(getucc[i].lengthb/100).toString()+"M' or product like '%*"+(getucc[i].lengthb/100).toString()+".0M' )";
						t_where="where=^^"+t_where+"^^";
						
						var txn=-1;
						for(var nas=0;nas<as_where.length;nas++){
							if(as_where[nas].t_where==t_where){
								txn=nas;
								break;
							}
						}
						
						if(as_where.length>0 && txn!=-1){
							$('#txtProductno__'+t_n).val(as_where[txn].noa);
							$('#txtProduct__'+t_n).val(as_where[txn].product);
							$('#txtUnit__'+t_n).val(as_where[txn].unit);
							$('#txtGmount__'+t_n).val(getucc[i].mount);
							$('#txtGweight__'+t_n).val(round(getucc[i].mount*t_weight*getucc[i].lengthb/100,0));
							$('#txtNor__'+t_n).val(getucc[i].nor);
							$('#txtMemo2__'+t_n).val(t_memo2);
							if(getucc[i].olengthb!=getucc[i].lengthb && dec(getucc[i].wlengthb)<=(getucc[i].olengthb-getucc[i].lengthb)){
								$('#txtLengthc__'+t_n).val(0);
							}else{
								$('#txtLengthc__'+t_n).val(dec(getucc[i].wlengthb));
							}
							/*$('#txtScolor__'+t_n).val(getucc[i].bolt);
							$('#txtHard__'+t_n).val(getucc[i].tlength);*/
							$('#txtMemo__'+t_n).val(t_memo3);
						}else{
							q_gt('ucc', t_where , 0, 0, 0, "getucc",r_accy,1); //號數
							var as = _q_appendData("ucc", "", true);
							if (as[0] != undefined) {
								$('#txtProductno__'+t_n).val(as[0].noa);
								$('#txtProduct__'+t_n).val(as[0].product);
								$('#txtUnit__'+t_n).val(as[0].unit);
								$('#txtGmount__'+t_n).val(getucc[i].mount);
								$('#txtGweight__'+t_n).val(round(getucc[i].mount*t_weight*getucc[i].lengthb/100,0));
								$('#txtNor__'+t_n).val(getucc[i].nor);
								$('#txtMemo2__'+t_n).val(t_memo2);
								if(getucc[i].olengthb!=getucc[i].lengthb && dec(getucc[i].wlengthb)<=(getucc[i].olengthb-getucc[i].lengthb)){
									$('#txtLengthc__'+t_n).val(0);
								}else{
									$('#txtLengthc__'+t_n).val(dec(getucc[i].wlengthb));
								}
								//$('#txtLengthc__'+t_n).val(dec(getucc[i].wlengthb));
								/*$('#txtScolor__'+t_n).val(getucc[i].bolt);
								$('#txtHard__'+t_n).val(getucc[i].tlength);*/
								$('#txtMemo__'+t_n).val(t_memo3);
								
								as_where.push({
									't_where':t_where,
									'noa':as[0].noa,
									'product':as[0].product,
									'unit':as[0].unit
								});
							}else{
								$('#txtProductno__'+t_n).val('');
								$('#txtProduct__'+t_n).val('鋼筋熱軋'+getucc[i].spec+' '+getucc[i].size+'*'+(getucc[i].lengthb/100).toString()+'M');
								$('#txtUnit__'+t_n).val('KG');
								$('#txtGmount__'+t_n).val(getucc[i].mount);
								$('#txtGweight__'+t_n).val(round(getucc[i].mount*t_weight*getucc[i].lengthb/100,2));
								$('#txtNor__'+t_n).val(getucc[i].nor);
								$('#txtMemo2__'+t_n).val(t_memo2);
								if(getucc[i].olengthb!=getucc[i].lengthb && dec(getucc[i].wlengthb)<=(getucc[i].olengthb-getucc[i].lengthb)){
									$('#txtLengthc__'+t_n).val(0);
								}else{
									$('#txtLengthc__'+t_n).val(dec(getucc[i].wlengthb));
								}
								//$('#txtLengthc__'+t_n).val(dec(getucc[i].wlengthb));
								/*$('#txtScolor__'+t_n).val(getucc[i].bolt);
								$('#txtHard__'+t_n).val(getucc[i].tlength);*/
								$('#txtMemo__'+t_n).val(t_memo3);
							}
						}
						t_n++;
					}
					
					sum();
					Unlock(1);
				});
			}
			
			var t_p1getucc=[];
			var t_p2getucc=[];
			var t_p3getucc=[];
			var t_p4getucc=[];
			
			var asknife=[];//定尺庫存可用長度
			
			function getp1 (){
				var t_err='';
				//---------------------------------------------------------------
				var t_sortlen=0;//最短裁剪限制長度
				q_gt('mech', "where=^^noa='"+$('#cmbMechno').val()+"'^^" , 0, 0, 0, "getmech",r_accy,1); //號數
				var as = _q_appendData("mech", "", true);
				if (as[0] != undefined) {
					t_sortlen=as[0].dime1;
				}
				
				var t_cutsheet=$('#combStatus').val();//可裁剪的板料長度
				var maxcutsheet=0;//最大板料長度
				if($('#combStatus').find("option:selected").text().length==0){
					t_cutsheet='12';
					t_cutsheet=t_cutsheet.split(',');
				}
				for (var i = 0; i < t_cutsheet.length; i++) {
					if(maxcutsheet<dec(t_cutsheet[i])*100){
						maxcutsheet=dec(t_cutsheet[i])*100;
					}
				}
				
				//106/03/23 已最大版料先下去配料
				t_cutsheet.sort(function(a, b) {if(a>b) {return -1;} if (a < b) {return 1;} return 0;})
				//---------------------------------------------------------------
				
				//相同材質號數長度合併
				//105/08/25 基礎螺栓 不用餘料裁剪 一起帶入組合裁剪 SD420W
				//105/08/25 安全存量 連同帶入表身資料
				var t_same=[]; //bbs可裁剪的內容(相同材質號數長度)
				for (var i = 0; i < q_bbsCount; i++) {
					if(!emp($('#txtProductno_'+i).val()) && !emp($('#txtProduct_'+i).val()) 
					&& ($('#txtProduct_'+i).val().indexOf('鋼筋')>-1 || $('#txtProduct_'+i).val().indexOf('螺栓')>-1)
					&& dec($('#txtLengthb_'+i).val())<=maxcutsheet){
						var tproduct=$('#txtProduct_'+i).val();
						var tmount=dec($('#txtMount_'+i).val());//裁剪數量
						//材質號數長度
						var tspec='';
						var tsize='';
						if(tproduct.indexOf('螺栓')>-1){
							tspec='SD420W';
							tsize=replaceAll(replaceAll(tproduct.split('#')[0]+'#','基礎螺栓',''),'抗震專利','');
						}else{ //鋼筋
							tspec=tproduct.substr(tproduct.indexOf('S'),tproduct.indexOf(' ')-tproduct.indexOf('S'));
							tsize=tproduct.split(' ')[1].split('*')[0];
						}
						var tlength=dec($('#txtLengthb_'+i).val());
						var twaste=dec($('#txtWaste').val()); //容許損耗長度
						var to=dec($('#txtMo').val()); //容許損耗%
						var tw03=dec($('#txtW03_'+i).val());// 圖形可誤差長度
							
						var t_j=-1;
						for (var j=0;j<t_same.length;j++){
							if(t_same[j].spec==tspec && t_same[j].size==tsize && t_same[j].lengthb==tlength){
								t_j=j;
								t_same[j].data.push({
									'nor':i,
									'mount':tmount,
									'tw03':tw03
								})
								t_same[j].mount=t_same[j].mount+tmount;
								break;
							}
						}
						
						if(t_j<0){
							t_same.push({
								'spec':tspec,
								'size':tsize,
								'lengthb':tlength,
								'mount':tmount,
								'data':[{
									'nor':i,
									'mount':tmount,
									'tw03':tw03
								}]
							});
						}
					}
				}
				
				var t_m9=dec($('#txtM9').val());
				if(t_m9<=0 || t_m9==undefined)
					t_m9=0;
				for (var i=0;i<t_same.length;i++){
					t_same[i].maxmount=round(t_same[i].mount*(t_m9/100),0);
				}
				
				//107/01/26加入可補足安全存量(非領用) //107/02/06 取消增量模式
				for (var i=0;i<safeas.length;i++){
					for (var j=0;j<t_same.length;j++){
						if(safeas[i].spec==t_same[j].spec && safeas[i].size==t_same[j].size && safeas[i].lengthb==t_same[j].lengthb){
							var t_mount=dec(safeas[i].addsafe);//-dec(safeas[i].mount);
							t_same[j].maxmount=q_add(dec(t_same[j].maxmount),t_mount);
						}
					}
				}
				
				var getucc=[];
				
				//107/01/31 排除可直接使用安全庫存
				for (var j=0;j<t_same.length;j++){
					for (var i=0;i<safehas.length;i++){
						if(safehas[i].spec==t_same[j].spec && safehas[i].size==t_same[j].size && safehas[i].lengthb==t_same[j].lengthb){
							if(t_same[j].mount<=safehas[i].smount){ //全部使用安全存量
								var t_nor='',t_noras=[];
								for (var k=0;k<t_same[j].data.length;k++){
									t_nor+=(t_nor.length>0?",":'')+(t_same[j].data[k].nor+1).toString();
									t_noras.push({
										'nor':t_same[j].data[k].nor+1,
										'mount':t_same[j].mount
									});
								}
								getucc.push({
									'spec':t_same[j].spec,
									'size':t_same[j].size,
									'lengthb':t_same[j].lengthb,
									'wlengthb':0,
									'mount':t_same[j].mount,
									'usemaxmount':t_same[j].maxmount,
									'nor':t_nor,
									'noras':t_noras,
									'cutlen':[t_same[j].lengthb],
									'data':[{'lengthb':t_same[j].lengthb,'mount':t_same[j].mount}],
									'typea':'s'
								});
								t_same.splice(j, 1);
								j--;
							}else{//部分
								var t_nor='',t_noras=[],t_smount=safehas[i].smount;
								for (var k=0;k<t_same[j].data.length;k++){
									if(t_smount>0 && t_same[j].data[k].mount>0){
										t_nor+=(t_nor.length>0?",":'')+(t_same[j].data[k].nor+1).toString();
										if(t_smount>=t_same[j].data[k].mount){
											t_noras.push({
												'nor':t_same[j].data[k].nor+1,
												'mount':t_same[j].data[k].mount
											});
											
											t_smount=t_smount-t_same[j].data[k].mount;
											t_same[j].mount=t_same[j].mount-t_same[j].data[k].mount
											t_same[j].data[k].mount=0;
											t_same[j].data.splice(k, 1);
											k--;
										}else{
											t_noras.push({
												'nor':t_same[j].data[k].nor+1,
												'mount':t_smount
											});
											
											t_same[j].data[k].mount=t_same[j].data[k].mount-t_smount;
											t_same[j].mount=t_same[j].mount-t_smount;
											t_smount=0;
										}
									}
								}
								
								getucc.push({
									'spec':t_same[j].spec,
									'size':t_same[j].size,
									'lengthb':t_same[j].lengthb,
									'wlengthb':0,
									'mount':safehas[i].smount,
									'usemaxmount':t_same[j].maxmount,
									'nor':t_nor,
									'noras':t_noras,
									'cutlen':[t_same[j].lengthb],
									'data':[{'lengthb':t_same[j].lengthb,'mount':safehas[i].smount}],
									'typea':'s'
								});
							}
							break;
						}
					}
				}
									
				//推算選料
				//先裁剪最大長度
				t_same.sort(function(a, b) {if(a.lengthb>b.lengthb) {return -1;} if (a.lengthb < b.lengthb) {return 1;} return 0;});
				
				var specsize='';//存放已做的材質和號數
				var as_add5=[];//暫存可使用板料長度
				var t_stlen=50; //取最小定尺尺寸
				for (var i=0;i<t_same.length;i++){
					var sheetlength=''; //板料可用長度
					//材質號數
					var tspec1=t_same[i].spec;
					var tsize1=t_same[i].size;
					//取得設定可使用的板料長度
					var add5n=-1;
					for(var x5n=0;x5n<as_add5.length;x5n++){
						if(as_add5[x5n].size==tsize1){
							add5n=x5n;
							break;
						}
					}
					
					if(as_add5.length>0 && add5n!=-1){
						sheetlength=as_add5[0].sheetlength;
					}else{
						q_gt('add5', "where=^^typea='"+tsize1+"'^^" , 0, 0, 0, "getadd5",r_accy,1); //號數
						var as = _q_appendData("add5s", "", true);
						for (var j=0;j<as.length;j++){
							sheetlength=sheetlength+as[j].postno+',';
						}
						
						as_add5.push({
							'size':tsize1,
							'sheetlength':sheetlength
						});
					}
					
					if(tsize1=='3#' || tsize1=='4#' || tsize1=='5#'){
						//取最小定尺尺寸
						if(t_same[0]!= undefined){
							q_gt('adknife', "where=^^ style='"+t_same[0].size+"'^^", 0, 0, 0, "getadknife",r_accy,1);
							var as = _q_appendData("adknife", "", true);
							if(as[0]!= undefined){
								if(as[0].memo.length>0){
									t_stlen=dec(replaceAll(as[0].memo.split('/')[0],'cm',''));
									asknife=replaceAll(as[0].memo,'cm','').split('/');
								}
							}
						}
						
						for(var j=0;j<asknife.length;j++){
							if(asknife[j]==''){
								asknife.splice(j, 1);
								j--;
							}else{
								asknife[j]=dec(asknife[j]);
							}
						}
						
					}
					
					if(specsize.indexOf(tspec1+tsize1+'#')==-1){//已做過的相同材質號數 不在做一次
						specsize=specsize+tspec1+tsize1+'#';
						var cutlengthb=[];//相同材質號數的長度
						var cutlengthballs=[];//相同材質號數的長度內 根據最大長度 可誤差長度
						var maxcutlengthb='0'; //最大長度
						var maxcutlengthbs=[];//最大長度可誤差長度
						
						//讀取相同材質號數的長度
						cutlengthb=[];
						for (var j=0;j<t_same.length;j++){
							var tspec2=t_same[j].spec;
							var tsize2=t_same[j].size;
							var tmount2=t_same[j].mount;
							var lengthb2=dec(t_same[j].lengthb);
							if(tspec1==tspec2 && tsize1==tsize2 && dec(tmount2)>0){
								cutlengthb.push(lengthb2);
							}
						}
						
						//裁剪長度排序(最短,...,最長)
						cutlengthb.sort(function(a, b) {if(a>b) {return 1;} if (a < b) {return -1;} return 0;});
						maxcutlengthb=cutlengthb[cutlengthb.length-1];
						
						//107/01/30 可直接整除的長度先不選擇
						for(var m=cutlengthb.length-1;m>0;m--){
							var t_ismod=false;
							for(var k=0;k<t_cutsheet.length;k++){
								var clength=(dec(t_cutsheet[k])*100);
								if(clength%dec(maxcutlengthb)==0){
									if(m>0)
										maxcutlengthb=cutlengthb[m-1];
									t_ismod=true;
									break;
								}
							}
							if(!t_ismod){
								break;
							}
						}
						
						//裁切組合
						var t_cups=[];
						while(cutlengthb.length>0){//已排序過 
							//106/04/24一個項次裁剪完，再重新取得組合 求得最小損耗
							//106/09/14 不受項次限制
							t_cups=[];
							
							//可變動長度b-------------------------------------------------------
							maxcutlengthbs=[];
							cutlengthballs=[];
							for (var j=0;j<t_same.length;j++){
								var tspec2=t_same[j].spec;
								var tsize2=t_same[j].size;
								var lengthb2=dec(t_same[j].lengthb);
								if(tspec1==tspec2 && tsize1==tsize2 && lengthb2==maxcutlengthb){
									maxcutlengthbs.push(lengthb2);
									ttarray=[];
									tchglenc=0;
									cutlengthballs.push({
										maxlength:lengthb2,
										chgmaxlength:lengthb2,
										//陣列,材質,號數,最大長度,變動的最大長度,可使用長度
										cutlengthbs:samew03length(t_same,tspec1,tsize1,dec(t_same[j].lengthb),lengthb2,cutlengthb,[])
									});
										
									for (var k=0;k<t_same[j].data.length;k++){
										var ttw03=dec(t_same[j].data[k].tw03);
										lengthb2=dec(t_same[j].lengthb);
										while(ttw03>0){
											lengthb2=lengthb2-1;
											var existscutlens=false;
											for(var l=0;l<maxcutlengthbs.length;l++){
												if(maxcutlengthbs[l]==lengthb2){
													existscutlens=true;
													break;
												}
											}
											if(!existscutlens){
												maxcutlengthbs.push(lengthb2);
												ttarray=[];
												tchglenc=0;
												cutlengthballs.push({
													maxlength:dec(t_same[j].lengthb),
													chgmaxlength:lengthb2,
													//陣列,材質,號數,最大長度,變動的最大長度,可使用長度
													cutlengthbs:samew03length(t_same,tspec1,tsize1,dec(t_same[j].lengthb),lengthb2,cutlengthb,[])
												});
											}
											ttw03--;
										}
									}
									break;
								}
							}						
							//可變動長度e-------------------------------------------------------
							
							var bcount=0;
							for(var k=0;k<t_cutsheet.length;k++){
								var clength=(dec(t_cutsheet[k])*100); //原單位M
								if(sheetlength.indexOf(t_cutsheet[k])>-1){//要使用板料=設定中可用的裁剪板料
									bcount++;
									//106/04/20 調整可裁減長度
									var iswlenzero=false;
									for (var l=0;l<maxcutlengthbs.length;l++){
										for (var m=0;m<cutlengthballs.length;m++){
											if(maxcutlengthbs[l]==cutlengthballs[m].chgmaxlength){
												//最短裁剪長度限制
												for(var x=0;x<cutlengthballs[m].cutlengthbs.length;x++){
													cutlengthb=cutlengthballs[m].cutlengthbs[x];
													maxcutlengthb=maxcutlengthbs[l];
													
													var cutlengthbs=[];
													var a_cutlengthbs=[];
													var b_cutlengthbs=[];
													//最短裁剪長度限制
													for(var n=0;n<cutlengthb.length;n++){
														if(dec(cutlengthb[n])!=dec(maxcutlengthb)){
															if(dec(t_sortlen)>=dec(cutlengthb[n])){
																a_cutlengthbs.push(dec(cutlengthb[n]));
															}else{
																b_cutlengthbs.push(dec(cutlengthb[n]));
															}
														}
													}
													cutlengthbs=a_cutlengthbs;
													cutlengthbs=cutlengthbs.concat(b_cutlengthbs);
													cutlengthbs=cutlengthbs.concat([dec(maxcutlengthb)]);
													rep='';
													var t_cup=getmlength(clength,clength,maxcutlengthb,cutlengthbs,'',[],t_same,tspec1,tsize1,t_stlen);
													t_cup.sort(function(a, b) { if(a.wrate > b.wrate) {return 1;} if (a.wrate < b.wrate) {return -1;}if(a.cutlength.split(',').length>b.cutlength.split(',').length) {return 1;}if(a.cutlength.split(',').length<b.cutlength.split(',').length) {return -1;}return 0;});
													t_cups=t_cups.concat(t_cup);
													
													//106/05/10 取到最無損號就不計算可誤差
													if(t_cup.length>0){
														if(t_cup[0].wlenhth==0){
															iswlenzero=true;
															break;
														}													
													}
												}
											}
											if(iswlenzero){break;}
										}
										if(iswlenzero){break;}
									}
								}
								
								t_cups.sort(function(a, b) {
									if(a.wrate > b.wrate) {return 1;} 
									if(a.wrate < b.wrate) {return -1;}
									return 0;
								});
								
								//107/02/01 若原長度已有最好組合衍伸長度就不做組合
								var t_levc=true;
								if(t_cups.length>0){
									if(t_cups[0].wrate==0){
										t_levc=false;
									}
								}
								
								if(dec($('#txtLevel').val())>0 && t_levc){
									var t_level=dec($('#txtLevel').val());
									if (t_level>0){
										clength=(dec(t_cutsheet[k])*100)+t_level; //原單位M
										if(sheetlength.indexOf(t_cutsheet[k])>-1){//要使用板料=設定中可用的裁剪板料
											bcount++;
											//106/04/20 調整可裁減長度
											var iswlenzero=false;
											for (var l=0;l<maxcutlengthbs.length;l++){
												for (var m=0;m<cutlengthballs.length;m++){
													if(maxcutlengthbs[l]==cutlengthballs[m].chgmaxlength){
														//最短裁剪長度限制
														for(var x=0;x<cutlengthballs[m].cutlengthbs.length;x++){
															cutlengthb=cutlengthballs[m].cutlengthbs[x];
															maxcutlengthb=maxcutlengthbs[l];
															
															var cutlengthbs=[];
															var a_cutlengthbs=[];
															var b_cutlengthbs=[];
															//最短裁剪長度限制
															for(var n=0;n<cutlengthb.length;n++){
																if(dec(cutlengthb[n])!=dec(maxcutlengthb)){
																	if(dec(t_sortlen)>=dec(cutlengthb[n])){
																		a_cutlengthbs.push(dec(cutlengthb[n]));
																	}else{
																		b_cutlengthbs.push(dec(cutlengthb[n]));
																	}
																}
															}
															cutlengthbs=a_cutlengthbs;
															cutlengthbs=cutlengthbs.concat(b_cutlengthbs);
															cutlengthbs=cutlengthbs.concat([dec(maxcutlengthb)]);
															rep='';
															var t_cup=getmlength(clength,clength,maxcutlengthb,cutlengthbs,'',[],t_same,tspec1,tsize1,t_stlen);
															t_cup.sort(function(a, b) { if(a.wrate > b.wrate) {return 1;} if (a.wrate < b.wrate) {return -1;}if(a.cutlength.split(',').length>b.cutlength.split(',').length) {return 1;}if(a.cutlength.split(',').length<b.cutlength.split(',').length) {return -1;}return 0;});
															t_cups=t_cups.concat(t_cup);
											
															//106/05/10 取到最無損號就不計算可誤差
															if(t_cup.length>0){
																if(t_cup[0].wlenhth==0){
																	iswlenzero=true;
																	break;
																}													
															}
														}
													}
													if(iswlenzero){break;}
												}
												if(iswlenzero){break;}
											}
										}
									}
								}
							}
							if(bcount==0){
								alert(tspec1+' '+tsize1+'無可使用的板料長度!!');
								break;
							}
							
							//處理最短裁剪長度限制
							if(t_sortlen>0){
								for(var k=0;k<t_cups.length;k++){
									var cupolength=t_cups[k].olength;//裁剪的板料長度
									var cupcutlength=t_cups[k].cutlength.split('#')[0].split(',');//切割長度
									var cupcutlength2=t_cups[k].cutlength.split('#')[0].split(',');//切割長度(無損耗長度)
									var cupcutwlength=dec(t_cups[k].cutlength.split('#')[1]);//損耗長度
									cupcutlength=cupcutlength.concat(cupcutwlength);//加損耗
									var changecup=true;
									for (var m=0;m<cupcutlength.length;m++){
										if(dec(cupcutlength[m])>=t_sortlen){
											changecup=false;
											break;
										}
									}
									if(changecup){ //剪裁長度低於最短裁剪長度
										//拿最小損耗長度當尾刀 加價損失(最小長度限制,已損耗長度,可配對長度,已裁剪長度,暫存裁剪陣列)
										var t_sortcup=getsortlen(dec(t_sortlen),dec(cupcutwlength),cupcutlength2,cupcutwlength,[]);
										t_sortcup.sort(function(a, b) { if(a.wrate > b.wrate) {return 1;} if (a.wrate < b.wrate) {return -1;} return 0;});
										
										if(t_sortcup.length>0){
											var tt_cutlength='';
											var tt_scutlength=t_sortcup[0].cutlength.split(',');
											
											if(dec(cupcutwlength)>0){//原裁剪已有損耗 排除第一筆長度
												tt_scutlength.splice(0, 1);
											}
											//將原裁剪內容變動
											for (var m=0;m<cupcutlength2.length;m++){
												for (var n=0;n<tt_scutlength.length;n++){
													if(cupcutlength2[m]==tt_scutlength[n]){
														cupcutlength2.splice(m, 1);
														m--;
														tt_scutlength.splice(n, 1);
														n--;
													}
												}
											}
											for (var m=0;m<cupcutlength2.length;m++){
												tt_cutlength=tt_cutlength+(tt_cutlength.length>0?',':'')+cupcutlength2[m];
											}
											tt_cutlength=tt_cutlength+'#'+t_sortcup[0].wlength;
											t_cups[k].cutlength=tt_cutlength;
											t_cups[k].wlenhth=t_sortcup[0].wlength;
											t_cups[k].wrate=t_sortcup[0].wlength/t_cups[k].olength;
										}
									}
								}
							}
							
							//取得所需數量
							var tt_same=[];
							for(var k=0;k<t_same.length;k++){
								var tspec2=t_same[k].spec;
								var tsize2=t_same[k].size;
								var lengthb2=t_same[k].lengthb;
								var tdata2=t_same[k].data;
								if(tspec1==tspec2 && tsize1==tsize2){
									for(var l=0;l<tdata2.length;l++){
										if(dec(tdata2[l].mount)>0){
											tt_same.push({
												'maxmount':t_same[k].maxmount,
												'lengthb':lengthb2,
												'mount':tdata2[l].mount,
												'nor':tdata2[l].nor,
												'tw03':tdata2[l].tw03
											});
										}
									}
								}
							}
							
							//調整最後剩餘數量是否符合最低損耗率
							for(var k=0;k<t_cups.length;k++){
								var cupcutlength=t_cups[k].cutlength.split('#')[0].split(',');//切割長度
								var cupcutwlength=dec(t_cups[k].cutlength.split('#')[1]);//損耗長度
								var cupolength=t_cups[k].olength;//裁剪的板料長度
								
								var cuttmp=[];//組合數量
								for (var m=0;m<cupcutlength.length;m++){//裁切數量
									var x_n=-1;
									for (var n=0;n<cuttmp.length;n++){
										if(cuttmp[n].lengthb==dec(cupcutlength[m])){
											cuttmp[n].mount=cuttmp[n].mount+1;
											x_n=n;
											break;	
										}
									}
									if(x_n==-1){
										cuttmp.push({
											'lengthb':dec(cupcutlength[m]),
											'mount':1
										});
									}
								}
								var t_wlength=dec(cupolength);
								/*if(t_wlength.toString().slice(-1)=='5'){
									t_wlength=dec(t_wlength.toString().substr(0,t_wlength.toString().length-1)+'0');
								}*/
								
								var t_cutlength='';
								for (var m=0;m<cuttmp.length;m++){
									for (var n=0;n<tt_same.length;n++){
										if(dec(cuttmp[m].mount)>0 && dec(cuttmp[m].lengthb)<=dec(tt_same[n].lengthb) && dec(cuttmp[m].lengthb)>=(dec(tt_same[n].lengthb)-dec(tt_same[n].tw03))){
											if(dec(cuttmp[m].mount)>dec(tt_same[n].mount)+dec(tt_same[n].maxmount)){
												t_wlength=q_sub(t_wlength,q_mul(dec(cuttmp[m].lengthb),dec(tt_same[n].mount)+dec(tt_same[n].maxmount)));
												var ttt_mount=dec(tt_same[n].mount)+dec(tt_same[n].maxmount);
												while(ttt_mount>0){
													t_cutlength=t_cutlength+(t_cutlength.length>0?',':'')+cuttmp[m].lengthb;
													ttt_mount--;
													cuttmp[m].mount=dec(cuttmp[m].mount)-1;
												}
											}else{
												t_wlength=q_sub(t_wlength,q_mul(dec(cuttmp[m].lengthb),cuttmp[m].mount));
												var ttt_mount=cuttmp[m].mount;
												while(ttt_mount>0){
													t_cutlength=t_cutlength+(t_cutlength.length>0?',':'')+cuttmp[m].lengthb;
													ttt_mount--;
													cuttmp[m].mount=dec(cuttmp[m].mount)-1;
												}
											}
											//106/09/14 不受項次限制
											//break;
										}
									}
								}
								if(t_wlength<0)
									t_wlength=0;
								t_cups[k].wlenhth=t_wlength;
								t_cups[k].wrate=t_wlength/dec(cupolength);
								t_cups[k].cutlength=t_cutlength+'#'+t_wlength;
							}
							
							//損耗率排序 低損耗>長板料>裁剪長度>裁剪次數
							//t_cups.sort(function(a, b) { if(a.wrate > b.wrate) {return 1;} if (a.wrate < b.wrate) {return -1;} if(a.olength > b.olength) {return -1;} if (a.olength < b.olength) {return 1;} return 0;});
							
							if(tsize1=='3#' || tsize1=='4#' || tsize1=='5#'){
								//刪除小於最小定尺的損耗組合
								for(var k=0;k<t_cups.length;k++){
									var ttlengthb=dec(t_cups[k].olength.toString().substr(0,t_cups[k].olength.toString().length-2)+'00');
									var t_wlen=t_cups[k].wlenhth;
									if(ttlengthb!=t_cups[k].olength && t_wlen<=(t_cups[k].olength-ttlengthb)){
										t_wlen=0;
									}
									
									if(t_wlen>0 && t_wlen<t_stlen){
										t_cups.splice(k, 1);
                                    	k--;
									}
								}
							}
							
							t_cups.sort(function(a, b) {
								if(a.wrate > b.wrate) {return 1;} 
								if(a.wrate < b.wrate) {return -1;}
								/*if(lengthmount(a.cutlength,t_same,maxcutlengthbs)>lengthmount(b.cutlength,t_same,maxcutlengthbs)){return -1;}
								if(lengthmount(a.cutlength,t_same,maxcutlengthbs)<lengthmount(b.cutlength,t_same,maxcutlengthbs)){return 1;}*/
								if(dec(a.olength.toString().substr(0,a.olength.toString().length-2)+'00') > dec(b.olength.toString().substr(0,b.olength.toString().length-2)+'00')) {return -1;}
								if(dec(a.olength.toString().substr(0,a.olength.toString().length-2)+'00') < dec(b.olength.toString().substr(0,b.olength.toString().length-2)+'00')) {return 1;}
								if(a.olength > b.olength) {return 1;} 
								if(a.olength < b.olength) {return -1;}
								if(lengthgroup(a.cutlength)>lengthgroup(b.cutlength)){return 1;}
								if(lengthgroup(a.cutlength)<lengthgroup(b.cutlength)){return -1;} 
								if(a.cutlength.split(',').length>b.cutlength.split(',').length) {return 1;}
								if(a.cutlength.split(',').length<b.cutlength.split(',').length) {return -1;}
								return 0;
							});
							
							var tt_zero=false;
							if(tt_same.length>0){//數量大於0才做 越小的長度有可能在之前的裁剪已裁剪出來
								var cuttmp=[];//組合數量
								//找出目前最大長度數量的組合與最小損耗
								var cupcutlength=t_cups[0].cutlength.split('#')[0].split(',');//切割長度
								var cupcutwlength=dec(t_cups[0].cutlength.split('#')[1]);//損耗長度
								var cupolength=t_cups[0].olength;//裁剪的板料長度
								
								var bmount=0;//板料使用數量
								//cupcutlength=cupcutlength.concat(cupcutwlength);//加損耗
								var usemax=0; //使用容許多入數量M09
								while(!tt_zero){ //當最大長度需裁剪量數量<0 或 其他剪裁長度需才剪量<0
									bmount++;
									for (var m=0;m<cupcutlength.length;m++){//裁切數量
										var x_n=-1;
										for (var n=0;n<cuttmp.length;n++){
											if(cuttmp[n].lengthb==dec(cupcutlength[m])){
												cuttmp[n].mount=cuttmp[n].mount+1;
												x_n=n;
												break;	
											}
										}
										if(x_n==-1){
											cuttmp.push({
												'lengthb':dec(cupcutlength[m]),
												'mount':1
											});
										}
										for (var n=0;n<tt_same.length;n++){
											if(dec(cupcutlength[m])<=dec(tt_same[n].lengthb) && dec(cupcutlength[m])>=(dec(tt_same[n].lengthb)-dec(tt_same[n].tw03))
												&& dec(tt_same[n].mount)+dec(tt_same[n].maxmount)>0
											){
												if(dec(tt_same[n].mount)>0)
													tt_same[n].mount=q_sub(tt_same[n].mount,1);
												else
													tt_same[n].maxmount=q_sub(tt_same[n].maxmount,1);
													
												//判斷是否還有其他相同長度
												if(dec(tt_same[n].mount)+dec(tt_same[n].maxmount)<=0){
													var x_nn=-1
													for (var x=0;x<tt_same.length;x++){
														if(dec(cupcutlength[m])<=dec(tt_same[x].lengthb) && dec(cupcutlength[m])>=(dec(tt_same[x].lengthb)-dec(tt_same[x].tw03))
															&& dec(tt_same[x].mount)>0
														){
															x_nn=x;
														}
													}
													if(x_nn==-1){
														tt_zero=true;
													}
												}
												
												//107/02/06 依據台料 判斷是否受項次限制
												/*if(!$('#chkCancel').prop('checked')){
													if(dec(tt_same[n].mount)+dec(tt_same[n].maxmount)<=0){
														tt_zero=true;
													}
													if(dec(tt_same[n].mount)<=0 && dec(tt_same[n].maxmount)>0){
														usemax++;
													}
												}*/
												
												break;
											}
										}
									}
									
									if(usemax>0){
										tt_zero=true;
									}
									
									//檢查下次裁剪是否會多裁剪的數量
									var t_nn=-1;
									if(!tt_zero){
										var ttt_same=$.extend(true,[], tt_same);
										for (var m=0;m<cupcutlength.length;m++){//裁切數量
											var isexist=false;//判斷是否還有被扣料
											for (var n=0;n<ttt_same.length;n++){
												if(dec(cupcutlength[m])<=dec(ttt_same[n].lengthb) && dec(cupcutlength[m])>=(dec(ttt_same[n].lengthb)-dec(ttt_same[n].tw03))
													&& dec(ttt_same[n].mount)+dec(ttt_same[n].maxmount)>0
												){
													if(dec(ttt_same[n].mount)>0){
														ttt_same[n].mount=q_sub(ttt_same[n].mount,1);
														t_nn=n;	
													}else
														ttt_same[n].maxmount=q_sub(ttt_same[n].maxmount,1);
													
													isexist=true;
													
													/*if(dec(ttt_same[n].mount)+dec(ttt_same[n].maxmount)<0){
														tt_zero=true;
													}*/
													break;
												}
											}
											if(!isexist)
												tt_zero=true;
										}
									}
									//判斷是否下次是否可被裁減
									if(t_nn==-1){
										tt_zero=true;
									}
								}
								cupcutlength=cupcutlength.concat(cupcutwlength);//加損耗
								getucc.push({
									'spec':tspec1,
									'size':tsize1,
									'lengthb':cupolength,
									'wlengthb':cupcutwlength,
									'mount':bmount,
									'usemaxmount':usemax,
									'nor':'',
									'cutlen':cupcutlength,
									'data':cuttmp,
									'typea':'b'
								});
							}
							
							var t_nor='';
							var t_noras=[];
							//扣除已裁切完的數量
							cuttmp.sort(function(a, b) { if(dec(a.lengthb) > dec(b.lengthb)) {return 1;} if (dec(a.lengthb) < dec(b.lengthb)) {return -1;} return 0;})
							for (var m=0;m<cuttmp.length;m++){
								for(var k=0;k<t_same.length;k++){
									var tspec2=t_same[k].spec;
									var tsize2=t_same[k].size;
									var lengthb2=t_same[k].lengthb;
									var tdata2=t_same[k].data;
									var texists2=false;
									for (var x=0;x<tdata2.length;x++){
										if(tspec1==tspec2 && tsize1==tsize2 && dec(tdata2[x].mount)>0 && dec(cuttmp[m].mount)>0 
											&& dec(cuttmp[m].lengthb)<=dec(lengthb2) && dec(cuttmp[m].lengthb)>=(dec(lengthb2)-dec(tdata2[x].tw03))
										){
											var tcutmount=0;
											if(t_same[k].data[x].mount>=cuttmp[m].mount){
												tcutmount=cuttmp[m].mount;
												t_same[k].mount=t_same[k].mount-cuttmp[m].mount;
												t_same[k].data[x].mount=t_same[k].data[x].mount-cuttmp[m].mount;
												cuttmp[m].mount=0;
											}else{
												tcutmount=t_same[k].data[x].mount;
												t_same[k].mount=t_same[k].mount-t_same[k].data[x].mount;
												cuttmp[m].mount=cuttmp[m].mount-t_same[k].data[x].mount;
												t_same[k].data[x].mount=0;
											}
											
											if(t_same[k].data[x].mount<0 && t_same[k].maxmount>0){
												t_same[k].maxmount=t_same[k].maxmount+t_same[k].data[x].mount;
											}
											if(t_same[k].maxmount<0){
												t_same[k].maxmount=0;
											}
											
											var tt_nor=t_nor.split(',');
											var tt_norexist=false;
											for(var o=0;o<tt_nor.length;o++){
												if(tt_nor[o]==(t_same[k].data[x].nor+1).toString()){
													tt_norexist=true;
													break;
												}
											}
											if(!tt_norexist){
												t_nor=t_nor+(t_nor.length>0?',':'')+(t_same[k].data[x].nor+1);
											}
											//106/09/14-------------------------------
											tt_norexist=false;
											for(var o=0;o<t_noras.length;o++){
												if(t_noras[o].nor==(t_same[k].data[x].nor+1).toString()){
													t_noras[o].mount=q_add(t_noras[o].mount,tcutmount);
													tt_norexist=true;
													break;
												}
											}
											if(!tt_norexist){
												t_noras.push({
													nor:(t_same[k].data[x].nor+1).toString(),
													mount:tcutmount
												});
											}
											//-----------------------------
											//106/09/14 不受項次限制
											//texists2=true;
											//break;
											if(cuttmp[m].mount<=0){
												texists2=true;
												break;
											}
										}
									}
									if(texists2){
										break;
									}
								}
							}
							//更新最後一個物料的配料項次
							if(getucc.length>0){
								if(getucc[getucc.length-1].nor=='')
									getucc[getucc.length-1].nor=t_nor;
								getucc[getucc.length-1].noras=t_noras;
							}
							
							//已裁剪完的長度已不需要
							//cutlengthb.splice(j, 1);
							//j--;
							//其他剪長的長度也刪除
							for(var m=0;m<cutlengthb.length;m++){
								for(var k=0;k<t_same.length;k++){
									var tspec2=t_same[k].spec;
									var tsize2=t_same[k].size;
									var lengthb2=t_same[k].lengthb;
									var mount2=t_same[k].mount;
									if(tspec1==tspec2 && tsize1==tsize2 && cutlengthb[m]==lengthb2 && mount2<=0){
										cutlengthb.splice(m, 1);
										m--;
									}
								}	
							}
						
							//重新排序--------------------------------------------------
							//讀取相同材質號數的長度
							cutlengthb=[];
							for (var j=0;j<t_same.length;j++){
								var tspec2=t_same[j].spec;
								var tsize2=t_same[j].size;
								var tmount2=t_same[j].mount;
								var lengthb2=dec(t_same[j].lengthb);
								if(tspec1==tspec2 && tsize1==tsize2 && dec(tmount2)>0){
									cutlengthb.push(lengthb2);
								}
							}
							
							//裁剪長度排序(最短,...,最長)
							cutlengthb.sort(function(a, b) {if(a>b) {return 1;} if (a < b) {return -1;} return 0;});
							maxcutlengthb=cutlengthb[cutlengthb.length-1];
							
							//107/01/30 可直接整除的長度先不選擇
							for(var m=cutlengthb.length-1;m>0;m--){
								var t_ismod=false;
								for(var k=0;k<t_cutsheet.length;k++){
									var clength=(dec(t_cutsheet[k])*100);
									if(clength%dec(maxcutlengthb)==0){
										if(m>0)
											maxcutlengthb=cutlengthb[m-1];
										t_ismod=true;
										break;
									}
								}
								if(!t_ismod){
									break;
								}
							}
						}
					}
				}
				
				t_p1getucc=$.extend(true,[], getucc);
				return;

			}
			
			function getp2 (){
				var t_err='';
				//---------------------------------------------------------------
				var t_sortlen=0;//最短裁剪限制長度
				q_gt('mech', "where=^^noa='"+$('#cmbMechno').val()+"'^^" , 0, 0, 0, "getmech",r_accy,1); //號數
				var as = _q_appendData("mech", "", true);
				if (as[0] != undefined) {
					t_sortlen=as[0].dime1;
				}
				
				var t_cutsheet=$('#combStatus').val();//可裁剪的板料長度
				var maxcutsheet=0;//最大板料長度
				if($('#combStatus').find("option:selected").text().length==0){
					t_cutsheet='12';
					t_cutsheet=t_cutsheet.split(',');
				}
				for (var i = 0; i < t_cutsheet.length; i++) {
					if(maxcutsheet<dec(t_cutsheet[i])*100){
						maxcutsheet=dec(t_cutsheet[i])*100;
					}
				}
				
				//106/03/23 已最大版料先下去配料
				t_cutsheet.sort(function(a, b) {if(a>b) {return -1;} if (a < b) {return 1;} return 0;})
				//---------------------------------------------------------------
				
				//相同材質號數長度合併
				//105/08/25 基礎螺栓 不用餘料裁剪 一起帶入組合裁剪 SD420W
				//105/08/25 安全存量 連同帶入表身資料
				var t_same=[]; //bbs可裁剪的內容(相同材質號數長度)
				for (var i = 0; i < q_bbsCount; i++) {
					if(!emp($('#txtProductno_'+i).val()) && !emp($('#txtProduct_'+i).val()) 
					&& ($('#txtProduct_'+i).val().indexOf('鋼筋')>-1 || $('#txtProduct_'+i).val().indexOf('螺栓')>-1)
					&& dec($('#txtLengthb_'+i).val())<=maxcutsheet){
						var tproduct=$('#txtProduct_'+i).val();
						var tmount=dec($('#txtMount_'+i).val());//裁剪數量
						//材質號數長度
						var tspec='';
						var tsize='';
						if(tproduct.indexOf('螺栓')>-1){
							tspec='SD420W';
							tsize=replaceAll(replaceAll(tproduct.split('#')[0]+'#','基礎螺栓',''),'抗震專利','');
						}else{ //鋼筋
							tspec=tproduct.substr(tproduct.indexOf('S'),tproduct.indexOf(' ')-tproduct.indexOf('S'));
							tsize=tproduct.split(' ')[1].split('*')[0];
						}
						var tlength=dec($('#txtLengthb_'+i).val());
						var twaste=dec($('#txtWaste').val()); //容許損耗長度
						var to=dec($('#txtMo').val()); //容許損耗%
						var tw03=dec($('#txtW03_'+i).val());// 圖形可誤差長度
							
						var t_j=-1;
						for (var j=0;j<t_same.length;j++){
							if(t_same[j].spec==tspec && t_same[j].size==tsize && t_same[j].lengthb==tlength){
								t_j=j;
								t_same[j].data.push({
									'nor':i,
									'mount':tmount,
									'tw03':tw03
								})
								t_same[j].mount=t_same[j].mount+tmount;
								break;
							}
						}
						
						if(t_j<0){
							t_same.push({
								'spec':tspec,
								'size':tsize,
								'lengthb':tlength,
								'mount':tmount,
								'data':[{
									'nor':i,
									'mount':tmount,
									'tw03':tw03
								}]
							});
						}
					}
				}
				
				var t_m9=dec($('#txtM9').val());
				if(t_m9<=0 || t_m9==undefined)
					t_m9=0;
				for (var i=0;i<t_same.length;i++){
					t_same[i].maxmount=round(t_same[i].mount*(t_m9/100),0);
				}
				
				//107/01/26加入可補足安全存量(非領用) //107/02/06 取消增量模式
				for (var i=0;i<safeas.length;i++){
					for (var j=0;j<t_same.length;j++){
						if(safeas[i].spec==t_same[j].spec && safeas[i].size==t_same[j].size && safeas[i].lengthb==t_same[j].lengthb){
							var t_mount=dec(safeas[i].addsafe);//-dec(safeas[i].mount);
							t_same[j].maxmount=q_add(dec(t_same[j].maxmount),t_mount);
						}
					}
				}
				
				var getucc=[];
				
				//107/01/31 排除可直接使用安全庫存
				for (var j=0;j<t_same.length;j++){
					for (var i=0;i<safehas.length;i++){
						if(safehas[i].spec==t_same[j].spec && safehas[i].size==t_same[j].size && safehas[i].lengthb==t_same[j].lengthb){
							if(t_same[j].mount<=safehas[i].smount){ //全部使用安全存量
								var t_nor='',t_noras=[];
								for (var k=0;k<t_same[j].data.length;k++){
									t_nor+=(t_nor.length>0?",":'')+(t_same[j].data[k].nor+1).toString();
									t_noras.push({
										'nor':t_same[j].data[k].nor+1,
										'mount':t_same[j].mount
									});
								}
								getucc.push({
									'spec':t_same[j].spec,
									'size':t_same[j].size,
									'lengthb':t_same[j].lengthb,
									'wlengthb':0,
									'mount':t_same[j].mount,
									'usemaxmount':t_same[j].maxmount,
									'nor':t_nor,
									'noras':t_noras,
									'cutlen':[t_same[j].lengthb],
									'data':[{'lengthb':t_same[j].lengthb,'mount':t_same[j].mount}],
									'typea':'s'
								});
								t_same.splice(j, 1);
								j--;
							}else{//部分
								var t_nor='',t_noras=[],t_smount=safehas[i].smount;
								for (var k=0;k<t_same[j].data.length;k++){
									if(t_smount>0 && t_same[j].data[k].mount>0){
										t_nor+=(t_nor.length>0?",":'')+(t_same[j].data[k].nor+1).toString();
										if(t_smount>=t_same[j].data[k].mount){
											t_noras.push({
												'nor':t_same[j].data[k].nor+1,
												'mount':t_same[j].data[k].mount
											});
											
											t_smount=t_smount-t_same[j].data[k].mount;
											t_same[j].mount=t_same[j].mount-t_same[j].data[k].mount
											t_same[j].data[k].mount=0;
											t_same[j].data.splice(k, 1);
											k--;
										}else{
											t_noras.push({
												'nor':t_same[j].data[k].nor+1,
												'mount':t_smount
											});
											
											t_same[j].data[k].mount=t_same[j].data[k].mount-t_smount;
											t_same[j].mount=t_same[j].mount-t_smount;
											t_smount=0;
										}
									}
								}
								
								getucc.push({
									'spec':t_same[j].spec,
									'size':t_same[j].size,
									'lengthb':t_same[j].lengthb,
									'wlengthb':0,
									'mount':safehas[i].smount,
									'usemaxmount':t_same[j].maxmount,
									'nor':t_nor,
									'noras':t_noras,
									'cutlen':[t_same[j].lengthb],
									'data':[{'lengthb':t_same[j].lengthb,'mount':safehas[i].smount}],
									'typea':'s'
								});
							}
							break;
						}
					}
				}
									
				//推算選料
				//先裁剪最大長度
				t_same.sort(function(a, b) {if(a.lengthb>b.lengthb) {return -1;} if (a.lengthb < b.lengthb) {return 1;} return 0;});
				
				var specsize='';//存放已做的材質和號數
				var as_add5=[];//暫存可使用板料長度
				var t_stlen=50; //取最小定尺尺寸
				for (var i=0;i<t_same.length;i++){
					var sheetlength=''; //板料可用長度
					//材質號數
					var tspec1=t_same[i].spec;
					var tsize1=t_same[i].size;
					//取得設定可使用的板料長度
					var add5n=-1;
					for(var x5n=0;x5n<as_add5.length;x5n++){
						if(as_add5[x5n].size==tsize1){
							add5n=x5n;
							break;
						}
					}
					
					if(as_add5.length>0 && add5n!=-1){
						sheetlength=as_add5[0].sheetlength;
					}else{
						q_gt('add5', "where=^^typea='"+tsize1+"'^^" , 0, 0, 0, "getadd5",r_accy,1); //號數
						var as = _q_appendData("add5s", "", true);
						for (var j=0;j<as.length;j++){
							sheetlength=sheetlength+as[j].postno+',';
						}
						
						as_add5.push({
							'size':tsize1,
							'sheetlength':sheetlength
						});
					}
					
					if(tsize1=='3#' || tsize1=='4#' || tsize1=='5#'){
						//取最小定尺尺寸
						if(t_same[0]!= undefined){
							q_gt('adknife', "where=^^ style='"+t_same[0].size+"'^^", 0, 0, 0, "getadknife",r_accy,1);
							var as = _q_appendData("adknife", "", true);
							if(as[0]!= undefined){
								if(as[0].memo.length>0){
									t_stlen=dec(replaceAll(as[0].memo.split('/')[0],'cm',''));
									asknife=replaceAll(as[0].memo,'cm','').split('/');
								}
							}
						}
						for(var j=0;j<asknife.length;j++){
							if(asknife[j]==''){
								asknife.splice(j, 1);
								j--;
							}else{
								asknife[j]=dec(asknife[j]);
							}
						}
					}
					
					if(specsize.indexOf(tspec1+tsize1+'#')==-1){//已做過的相同材質號數 不在做一次
						specsize=specsize+tspec1+tsize1+'#';
						var cutlengthb=[];//相同材質號數的長度
						var cutlengthballs=[];//相同材質號數的長度內 根據最大長度 可誤差長度
						var maxcutlengthb='0'; //最大長度
						var maxcutlengthbs=[];//最大長度可誤差長度
						
						//讀取相同材質號數的長度
						cutlengthb=[];
						cutlengthballs=[];
						maxcutlengthb='0';
						maxcutlengthbs=[];
						
						var t_cutlengthb=[];
						for (var j=0;j<t_same.length;j++){
							var tspec2=t_same[j].spec;
							var tsize2=t_same[j].size;
							var tmount2=t_same[j].mount;
							var lengthb2=dec(t_same[j].lengthb);
							if(tspec1==tspec2 && tsize1==tsize2 && dec(tmount2)>0){
								t_cutlengthb.push({
									'lengthb':lengthb2,
									'mount':tmount2
								});
							}
						}
						t_cutlengthb.sort(function(a, b) {if(a.mount>b.mount) {return -1;} if (a.mount < b.mount) {return 1;} if(a.lengthb>b.lengthb) {return 1;} if (a.lengthb < b.lengthb) {return -1;} return 0;});
						for (var j=0;j<t_cutlengthb.length;j++){
							cutlengthb.push(t_cutlengthb[j].lengthb);
						}
						maxcutlengthb=cutlengthb[0];
						//----------------------------------------------------------------------
													
						//裁切組合
						var t_cups=[];
						var t_cupsp=false;
						while(cutlengthb.length>0){//已排序過 
							//一個項次裁剪完，再重新取得組合 求得最小損耗
							//106/09/14 不受項次限制
							t_cups=[];
							//可變動長度b-------------------------------------------------------
							maxcutlengthbs=[];
							cutlengthballs=[];
							for (var j=0;j<t_same.length;j++){
								var tspec2=t_same[j].spec;
								var tsize2=t_same[j].size;
								var lengthb2=dec(t_same[j].lengthb);
								if(tspec1==tspec2 && tsize1==tsize2 && lengthb2==maxcutlengthb){
									maxcutlengthbs.push(lengthb2);
									ttarray=[];
									tchglenc=0;
									cutlengthballs.push({
										maxlength:lengthb2,
										chgmaxlength:lengthb2,
										//陣列,材質,號數,最大長度,變動的最大長度,可使用長度
										cutlengthbs:samew03length(t_same,tspec1,tsize1,dec(t_same[j].lengthb),lengthb2,cutlengthb,[])
									});
										
									for (var k=0;k<t_same[j].data.length;k++){
										var ttw03=dec(t_same[j].data[k].tw03);
										lengthb2=dec(t_same[j].lengthb);
										while(ttw03>0){
											lengthb2=lengthb2-1;
											var existscutlens=false;
											for(var l=0;l<maxcutlengthbs.length;l++){
												if(maxcutlengthbs[l]==lengthb2){
													existscutlens=true;
													break;
												}
											}
											if(!existscutlens){
												maxcutlengthbs.push(lengthb2);
												ttarray=[];
												tchglenc=0;
												cutlengthballs.push({
													maxlength:dec(t_same[j].lengthb),
													chgmaxlength:lengthb2,
													//陣列,材質,號數,最大長度,變動的最大長度,可使用長度
													cutlengthbs:samew03length(t_same,tspec1,tsize1,dec(t_same[j].lengthb),lengthb2,cutlengthb,[])
												});
											}
											ttw03--;
										}
									}
									break;
								}
							}						
							//可變動長度e-------------------------------------------------------
							var bcount=0;
							for(var k=0;k<t_cutsheet.length;k++){
								var clength=(dec(t_cutsheet[k])*100); //原單位M
								if(sheetlength.indexOf(t_cutsheet[k])>-1){//要使用板料=設定中可用的裁剪板料
									bcount++;
									//106/04/20 調整可裁減長度
									var iswlenzero=false;
									for (var l=0;l<maxcutlengthbs.length;l++){
										for (var m=0;m<cutlengthballs.length;m++){
											if(maxcutlengthbs[l]==cutlengthballs[m].chgmaxlength){
												//最短裁剪長度限制
												for(var x=0;x<cutlengthballs[m].cutlengthbs.length;x++){
													cutlengthb=cutlengthballs[m].cutlengthbs[x];
													maxcutlengthb=maxcutlengthbs[l];
													
													var cutlengthbs=[];
													var a_cutlengthbs=[];
													var b_cutlengthbs=[];
													//最短裁剪長度限制
													for(var n=0;n<cutlengthb.length;n++){
														if(dec(cutlengthb[n])!=dec(maxcutlengthb)){
															if(dec(t_sortlen)>=dec(cutlengthb[n])){
																a_cutlengthbs.push(dec(cutlengthb[n]));
															}else{
																b_cutlengthbs.push(dec(cutlengthb[n]));
															}
														}
													}
													//cutlengthbs=[dec(maxcutlengthb)];
													//cutlengthbs=cutlengthbs.concat(a_cutlengthbs);
													//cutlengthbs=cutlengthbs.concat(b_cutlengthbs);
													
													cutlengthbs=$.extend(true,[], a_cutlengthbs);
													cutlengthbs=cutlengthbs.concat(b_cutlengthbs);
													cutlengthbs=cutlengthbs.concat([dec(maxcutlengthb)]);
													rep='';
													t_cupsp=false;
													var t_cup=getmlength2(clength,clength,maxcutlengthb,cutlengthbs,'',[],t_same,tspec1,tsize1);
													if(t_cup.length==0){
														rep='';
														t_cup=getmlength(clength,clength,maxcutlengthb,cutlengthbs,'',[],t_same,tspec1,tsize1,t_stlen);
													}else{
														t_cupsp=true;
													}
													t_cup.sort(function(a, b) { if(a.wrate > b.wrate) {return 1;} if (a.wrate < b.wrate) {return -1;}if(a.cutlength.split(',').length>b.cutlength.split(',').length) {return 1;}if(a.cutlength.split(',').length<b.cutlength.split(',').length) {return -1;}return 0;});
													t_cups=t_cups.concat(t_cup);
													
													//106/05/10 取到最無損號就不計算可誤差
													if(t_cup.length>0){
														if(t_cup[0].wlenhth==0){
															iswlenzero=true;
															break;
														}													
													}
												}
											}
											if(iswlenzero){break;}
										}
										if(iswlenzero){break;}
									}
								}
								
								t_cups.sort(function(a, b) {
									if(a.wrate > b.wrate) {return 1;} 
									if(a.wrate < b.wrate) {return -1;}
									return 0;
								});
								
								//107/02/01 若原長度已有最好組合衍伸長度就不做組合
								var t_levc=true;
								if(t_cups.length>0){
									if(t_cups[0].wrate==0){
										t_levc=false;
									}
								}
								
								if(dec($('#txtLevel').val())>0 && t_levc){
									var t_level=dec($('#txtLevel').val());
									if (t_level>0){
										clength=(dec(t_cutsheet[k])*100)+t_level; //原單位M
										if(sheetlength.indexOf(t_cutsheet[k])>-1){//要使用板料=設定中可用的裁剪板料
											bcount++;
											//106/04/20 調整可裁減長度
											var iswlenzero=false;
											for (var l=0;l<maxcutlengthbs.length;l++){
												for (var m=0;m<cutlengthballs.length;m++){
													if(maxcutlengthbs[l]==cutlengthballs[m].chgmaxlength){
														//最短裁剪長度限制
														for(var x=0;x<cutlengthballs[m].cutlengthbs.length;x++){
															cutlengthb=cutlengthballs[m].cutlengthbs[x];
															maxcutlengthb=maxcutlengthbs[l];
															
															var cutlengthbs=[];
															var a_cutlengthbs=[];
															var b_cutlengthbs=[];
															//最短裁剪長度限制
															for(var n=0;n<cutlengthb.length;n++){
																if(dec(cutlengthb[n])!=dec(maxcutlengthb)){
																	if(dec(t_sortlen)>=dec(cutlengthb[n])){
																		a_cutlengthbs.push(dec(cutlengthb[n]));
																	}else{
																		b_cutlengthbs.push(dec(cutlengthb[n]));
																	}
																}
															}
															
															//cutlengthbs=[dec(maxcutlengthb)];
															//cutlengthbs=cutlengthbs.concat(a_cutlengthbs);
															//cutlengthbs=cutlengthbs.concat(b_cutlengthbs);
															
															cutlengthbs=$.extend(true,[], a_cutlengthbs);
															cutlengthbs=cutlengthbs.concat(b_cutlengthbs);
															cutlengthbs=cutlengthbs.concat([dec(maxcutlengthb)]);
															rep='';
															var t_cup=getmlength2(clength,clength,maxcutlengthb,cutlengthbs,'',[],t_same,tspec1,tsize1);
															if(t_cup.length==0 && !t_cupsp){
																rep='';
																t_cup=getmlength(clength,clength,maxcutlengthb,cutlengthbs,'',[],t_same,tspec1,tsize1,t_stlen);
															}
															t_cup.sort(function(a, b) { if(a.wrate > b.wrate) {return 1;} if (a.wrate < b.wrate) {return -1;}if(a.cutlength.split(',').length>b.cutlength.split(',').length) {return 1;}if(a.cutlength.split(',').length<b.cutlength.split(',').length) {return -1;}return 0;});
															t_cups=t_cups.concat(t_cup);
															
															//106/05/10 取到最無損號就不計算可誤差
															if(t_cup.length>0){
																if(t_cup[0].wlenhth==0){
																	iswlenzero=true;
																	break;
																}													
															}
														}
													}
													if(iswlenzero){break;}
												}
												if(iswlenzero){break;}
											}
										}
									}
								}
							}
							if(bcount==0){
								alert(tspec1+' '+tsize1+'無可使用的板料長度!!');
								break;
							}
							
							//處理最短裁剪長度限制
							if(t_sortlen>0){
								for(var k=0;k<t_cups.length;k++){
									var cupolength=t_cups[k].olength;//裁剪的板料長度
									var cupcutlength=t_cups[k].cutlength.split('#')[0].split(',');//切割長度
									var cupcutlength2=t_cups[k].cutlength.split('#')[0].split(',');//切割長度(無損耗長度)
									var cupcutwlength=dec(t_cups[k].cutlength.split('#')[1]);//損耗長度
									cupcutlength=cupcutlength.concat(cupcutwlength);//加損耗
									var changecup=true;
									for (var m=0;m<cupcutlength.length;m++){
										if(dec(cupcutlength[m])>=t_sortlen){
											changecup=false;
											break;
										}
									}
									if(changecup){ //剪裁長度低於最短裁剪長度
										//拿最小損耗長度當尾刀 加價損失(最小長度限制,已損耗長度,可配對長度,已裁剪長度,暫存裁剪陣列)
										var t_sortcup=getsortlen(dec(t_sortlen),dec(cupcutwlength),cupcutlength2,cupcutwlength,[]);
										t_sortcup.sort(function(a, b) { if(a.wrate > b.wrate) {return 1;} if (a.wrate < b.wrate) {return -1;} return 0;});
										
										if(t_sortcup.length>0){
											var tt_cutlength='';
											var tt_scutlength=t_sortcup[0].cutlength.split(',');
											
											if(dec(cupcutwlength)>0){//原裁剪已有損耗 排除第一筆長度
												tt_scutlength.splice(0, 1);
											}
											//將原裁剪內容變動
											for (var m=0;m<cupcutlength2.length;m++){
												for (var n=0;n<tt_scutlength.length;n++){
													if(cupcutlength2[m]==tt_scutlength[n]){
														cupcutlength2.splice(m, 1);
														m--;
														tt_scutlength.splice(n, 1);
														n--;
													}
												}
											}
											for (var m=0;m<cupcutlength2.length;m++){
												tt_cutlength=tt_cutlength+(tt_cutlength.length>0?',':'')+cupcutlength2[m];
											}
											tt_cutlength=tt_cutlength+'#'+t_sortcup[0].wlength;
											t_cups[k].cutlength=tt_cutlength;
											t_cups[k].wlenhth=t_sortcup[0].wlength;
											t_cups[k].wrate=t_sortcup[0].wlength/t_cups[k].olength;
										}
									}
								}
							}
							
							//取得所需數量
							var tt_same=[];
							for(var k=0;k<t_same.length;k++){
								var tspec2=t_same[k].spec;
								var tsize2=t_same[k].size;
								var lengthb2=t_same[k].lengthb;
								var tdata2=t_same[k].data;
								if(tspec1==tspec2 && tsize1==tsize2){
									for(var l=0;l<tdata2.length;l++){
										if(dec(tdata2[l].mount)>0){
											tt_same.push({
												'maxmount':t_same[k].maxmount,
												'lengthb':lengthb2,
												'mount':tdata2[l].mount,
												'nor':tdata2[l].nor,
												'tw03':tdata2[l].tw03
											});
										}
									}
								}
							}
							
							//調整最後剩餘數量是否符合最低損耗率
							for(var k=0;k<t_cups.length;k++){
								var cupcutlength=t_cups[k].cutlength.split('#')[0].split(',');//切割長度
								var cupcutwlength=dec(t_cups[k].cutlength.split('#')[1]);//損耗長度
								var cupolength=t_cups[k].olength;//裁剪的板料長度
								
								var cuttmp=[];//組合數量
								for (var m=0;m<cupcutlength.length;m++){//裁切數量
									var x_n=-1;
									for (var n=0;n<cuttmp.length;n++){
										if(cuttmp[n].lengthb==dec(cupcutlength[m])){
											cuttmp[n].mount=cuttmp[n].mount+1;
											x_n=n;
											break;	
										}
									}
									if(x_n==-1){
										cuttmp.push({
											'lengthb':dec(cupcutlength[m]),
											'mount':1
										});
									}
								}
								var t_wlength=dec(cupolength);
								/*if(t_wlength.toString().slice(-1)=='5'){
									t_wlength=dec(t_wlength.toString().substr(0,t_wlength.toString().length-1)+'0');
								}*/
								
								var t_cutlength='';
								for (var m=0;m<cuttmp.length;m++){
									for (var n=0;n<tt_same.length;n++){
										if(dec(cuttmp[m].mount)>0 && dec(cuttmp[m].lengthb)<=dec(tt_same[n].lengthb) && dec(cuttmp[m].lengthb)>=(dec(tt_same[n].lengthb)-dec(tt_same[n].tw03))){
											if(dec(cuttmp[m].mount)>dec(tt_same[n].mount)+dec(tt_same[n].maxmount)){
												t_wlength=q_sub(t_wlength,q_mul(dec(cuttmp[m].lengthb),dec(tt_same[n].mount)+dec(tt_same[n].maxmount)));
												var ttt_mount=dec(tt_same[n].mount)+dec(tt_same[n].maxmount);
												while(ttt_mount>0){
													t_cutlength=t_cutlength+(t_cutlength.length>0?',':'')+cuttmp[m].lengthb;
													ttt_mount--;
													cuttmp[m].mount=dec(cuttmp[m].mount)-1;
												}
											}else{
												t_wlength=q_sub(t_wlength,q_mul(dec(cuttmp[m].lengthb),cuttmp[m].mount));
												var ttt_mount=cuttmp[m].mount;
												while(ttt_mount>0){
													t_cutlength=t_cutlength+(t_cutlength.length>0?',':'')+cuttmp[m].lengthb;
													ttt_mount--;
													cuttmp[m].mount=dec(cuttmp[m].mount)-1;
												}
											}
											//106/09/14 不受項次限制
											//break;
										}
									}
								}
								if(t_wlength<0)
									t_wlength=0;
								t_cups[k].wlenhth=t_wlength;
								t_cups[k].wrate=t_wlength/dec(cupolength);
								t_cups[k].cutlength=t_cutlength+'#'+t_wlength;
							}
							
							//損耗率排序 低損耗>長板料>裁剪長度>裁剪次數
							//t_cups.sort(function(a, b) { if(a.wrate > b.wrate) {return 1;} if (a.wrate < b.wrate) {return -1;} if(a.olength > b.olength) {return -1;} if (a.olength < b.olength) {return 1;} return 0;});
							
							if(tsize1=='3#' || tsize1=='4#' || tsize1=='5#'){
								//刪除小於最小定尺的損耗組合
								for(var k=0;k<t_cups.length;k++){
									var ttlengthb=dec(t_cups[k].olength.toString().substr(0,t_cups[k].olength.toString().length-2)+'00');
									var t_wlen=t_cups[k].wlenhth;
									if(ttlengthb!=t_cups[k].olength && t_wlen<=(t_cups[k].olength-ttlengthb)){
										t_wlen=0;
									}
									
									if(t_wlen>0 && t_wlen<t_stlen){
										t_cups.splice(k, 1);
                                    	k--;
									}
								}
							}
							
							t_cups.sort(function(a, b) { 
								if(a.wrate > b.wrate) {return 1;} 
								if(a.wrate < b.wrate) {return -1;}
								/*if(lengthmount(a.cutlength,t_same,maxcutlengthbs)>lengthmount(b.cutlength,t_same,maxcutlengthbs)){return -1;}
								if(lengthmount(a.cutlength,t_same,maxcutlengthbs)<lengthmount(b.cutlength,t_same,maxcutlengthbs)){return 1;}*/
								if(dec(a.olength.toString().substr(0,a.olength.toString().length-2)+'00') > dec(b.olength.toString().substr(0,b.olength.toString().length-2)+'00')) {return -1;}
								if(dec(a.olength.toString().substr(0,a.olength.toString().length-2)+'00') < dec(b.olength.toString().substr(0,b.olength.toString().length-2)+'00')) {return 1;}
								if(a.olength > b.olength) {return -1;} 
								if(a.olength < b.olength) {return 1;}
								if(lengthgroup(a.cutlength)>lengthgroup(b.cutlength)){return 1;}
								if(lengthgroup(a.cutlength)<lengthgroup(b.cutlength)){return -1;} 
								if(a.cutlength.split(',').length>b.cutlength.split(',').length) {return 1;}
								if(a.cutlength.split(',').length<b.cutlength.split(',').length) {return -1;}
								return 0;
							});
							
							var tt_zero=false;
							if(tt_same.length>0){//數量大於0才做 越小的長度有可能在之前的裁剪已裁剪出來
								var cuttmp=[];//組合數量
								//找出目前最大長度數量的組合與最小損耗
								var cupcutlength=t_cups[0].cutlength.split('#')[0].split(',');//切割長度
								var cupcutwlength=dec(t_cups[0].cutlength.split('#')[1]);//損耗長度
								var cupolength=t_cups[0].olength;//裁剪的板料長度
								
								var bmount=0;//板料使用數量
								//cupcutlength=cupcutlength.concat(cupcutwlength);//加損耗
								var usemax=0; //使用容許多入數量M09
								while(!tt_zero){ //當最大長度需裁剪量數量<0 或 其他剪裁長度需才剪量<0
									bmount++;
									for (var m=0;m<cupcutlength.length;m++){//裁切數量
										var x_n=-1;
										for (var n=0;n<cuttmp.length;n++){
											if(cuttmp[n].lengthb==dec(cupcutlength[m])){
												cuttmp[n].mount=cuttmp[n].mount+1;
												x_n=n;
												break;	
											}
										}
										if(x_n==-1){
											cuttmp.push({
												'lengthb':dec(cupcutlength[m]),
												'mount':1
											});
										}
										for (var n=0;n<tt_same.length;n++){
											if(dec(cupcutlength[m])<=dec(tt_same[n].lengthb) && dec(cupcutlength[m])>=(dec(tt_same[n].lengthb)-dec(tt_same[n].tw03))
												&& dec(tt_same[n].mount)+dec(tt_same[n].maxmount)>0
											){
												if(dec(tt_same[n].mount)>0)
													tt_same[n].mount=q_sub(tt_same[n].mount,1);
												else
													tt_same[n].maxmount=q_sub(tt_same[n].maxmount,1);
													
												//判斷是否還有其他相同長度
												if(dec(tt_same[n].mount)+dec(tt_same[n].maxmount)<=0){
													var x_nn=-1
													for (var x=0;x<tt_same.length;x++){
														if(dec(cupcutlength[m])<=dec(tt_same[x].lengthb) && dec(cupcutlength[m])>=(dec(tt_same[x].lengthb)-dec(tt_same[x].tw03))
															&& dec(tt_same[x].mount)>0
														){
															x_nn=x;
														}
													}
													if(x_nn==-1){
														tt_zero=true;
													}
												}
												
												//107/02/06 依據台料 判斷是否受項次限制
												/*if(!$('#chkCancel').prop('checked')){
													if(dec(tt_same[n].mount)+dec(tt_same[n].maxmount)<=0){
														tt_zero=true;
													}
													if(dec(tt_same[n].mount)<=0 && dec(tt_same[n].maxmount)>0){
														usemax++;
													}
												}*/
												
												break;
											}
										}
									}
									
									if(usemax>0){
										tt_zero=true;
									}
									
									//檢查下次裁剪是否會多裁剪的數量
									var t_nn=-1;
									if(!tt_zero){
										var ttt_same=$.extend(true,[], tt_same);
										for (var m=0;m<cupcutlength.length;m++){//裁切數量
											var isexist=false;//判斷是否還有被扣料
											for (var n=0;n<ttt_same.length;n++){
												if(dec(cupcutlength[m])<=dec(ttt_same[n].lengthb) && dec(cupcutlength[m])>=(dec(ttt_same[n].lengthb)-dec(ttt_same[n].tw03))
													&& dec(ttt_same[n].mount)+dec(ttt_same[n].maxmount)>0
												){
													if(dec(ttt_same[n].mount)>0){
														ttt_same[n].mount=q_sub(ttt_same[n].mount,1);
														t_nn=n;	
													}else
														ttt_same[n].maxmount=q_sub(ttt_same[n].maxmount,1);
													
													isexist=true;
													
													/*if(dec(ttt_same[n].mount)+dec(ttt_same[n].maxmount)<0){
														tt_zero=true;
													}*/
													break;
												}
											}
											if(!isexist)
												tt_zero=true;
										}
									}
									//判斷是否下次是否可被裁減
									if(t_nn==-1){
										tt_zero=true;
									}
								}
								cupcutlength=cupcutlength.concat(cupcutwlength);//加損耗
								getucc.push({
									'spec':tspec1,
									'size':tsize1,
									'lengthb':cupolength,
									'wlengthb':cupcutwlength,
									'mount':bmount,
									'usemaxmount':usemax,
									'nor':'',
									'cutlen':cupcutlength,
									'data':cuttmp,
									'typea':'b'
								});
							}
							
							var t_nor='';
							var t_noras=[];
							//扣除已裁切完的數量
							cuttmp.sort(function(a, b) { if(dec(a.lengthb) > dec(b.lengthb)) {return 1;} if (dec(a.lengthb) < dec(b.lengthb)) {return -1;} return 0;})
							for (var m=0;m<cuttmp.length;m++){
								for(var k=0;k<t_same.length;k++){
									var tspec2=t_same[k].spec;
									var tsize2=t_same[k].size;
									var lengthb2=t_same[k].lengthb;
									var tdata2=t_same[k].data;
									var texists2=false;
									for (var x=0;x<tdata2.length;x++){
										if(tspec1==tspec2 && tsize1==tsize2 && dec(tdata2[x].mount)>0 
											&& dec(cuttmp[m].lengthb)<=dec(lengthb2) && dec(cuttmp[m].lengthb)>=(dec(lengthb2)-dec(tdata2[x].tw03))
										){
											var tcutmount=0;
											if(t_same[k].data[x].mount>=cuttmp[m].mount){
												tcutmount=cuttmp[m].mount;
												t_same[k].mount=t_same[k].mount-cuttmp[m].mount;
												t_same[k].data[x].mount=t_same[k].data[x].mount-cuttmp[m].mount;
												cuttmp[m].mount=0;
											}else{
												tcutmount=t_same[k].data[x].mount;
												t_same[k].mount=t_same[k].mount-t_same[k].data[x].mount;
												cuttmp[m].mount=cuttmp[m].mount-t_same[k].data[x].mount;
												t_same[k].data[x].mount=0;
											}
											
											if(t_same[k].data[x].mount<0 && t_same[k].maxmount>0){
												t_same[k].maxmount=t_same[k].maxmount+t_same[k].data[x].mount;
											}
											if(t_same[k].maxmount<0){
												t_same[k].maxmount=0;
											}
											
											var tt_nor=t_nor.split(',');
											var tt_norexist=false;
											for(var o=0;o<tt_nor.length;o++){
												if(tt_nor[o]==(t_same[k].data[x].nor+1).toString()){
													tt_norexist=true;
													break;
												}
											}
											if(!tt_norexist){
												t_nor=t_nor+(t_nor.length>0?',':'')+(t_same[k].data[x].nor+1);
											}
											//106/09/14-------------------------------
											tt_norexist=false;
											for(var o=0;o<t_noras.length;o++){
												if(t_noras[o].nor==(t_same[k].data[x].nor+1).toString()){
													t_noras[o].mount=q_add(t_noras[o].mount,tcutmount);
													tt_norexist=true;
													break;
												}
											}
											if(!tt_norexist){
												t_noras.push({
													nor:(t_same[k].data[x].nor+1).toString(),
													mount:tcutmount
												});
											}
											//-----------------------------
											//106/09/14 不受項次限制
											//texists2=true;
											//break;
											if(cuttmp[m].mount<=0){
												texists2=true;
												break;
											}
										}
									}
									if(texists2){
										break;
									}
								}
							}
							//更新最後一個物料的配料項次
							if(getucc.length>0){
								if(getucc[getucc.length-1].nor=='')
									getucc[getucc.length-1].nor=t_nor;
								getucc[getucc.length-1].noras=t_noras;
							}
							
							//已裁剪完的長度已不需要
							//cutlengthb.splice(j, 1);
							//j--;
							//其他剪長的長度也刪除
							for(var m=0;m<cutlengthb.length;m++){
								for(var k=0;k<t_same.length;k++){
									var tspec2=t_same[k].spec;
									var tsize2=t_same[k].size;
									var lengthb2=t_same[k].lengthb;
									var mount2=t_same[k].mount;
									if(tspec1==tspec2 && tsize1==tsize2 && cutlengthb[m]==lengthb2 && mount2<=0){
										cutlengthb.splice(m, 1);
										m--;
									}
								}	
							}
						
							//重新排序--------------------------------------------------
							//讀取相同材質號數的長度
							cutlengthb=[];
							cutlengthballs=[];
							maxcutlengthb='0';
							maxcutlengthbs=[];
							
							var t_cutlengthb=[];
							for (var j=0;j<t_same.length;j++){
								var tspec2=t_same[j].spec;
								var tsize2=t_same[j].size;
								var tmount2=t_same[j].mount;
								var lengthb2=dec(t_same[j].lengthb);
								if(tspec1==tspec2 && tsize1==tsize2 && dec(tmount2)>0){
									t_cutlengthb.push({
										'lengthb':lengthb2,
										'mount':tmount2
									});
								}
							}
							t_cutlengthb.sort(function(a, b) {if(a.mount>b.mount) {return -1;} if (a.mount < b.mount) {return 1;} if(a.lengthb>b.lengthb) {return 1;} if (a.lengthb < b.lengthb) {return -1;} return 0;});
							for (var j=0;j<t_cutlengthb.length;j++){
								cutlengthb.push(t_cutlengthb[j].lengthb);
							}
							maxcutlengthb=cutlengthb[0];
						}
					}
				}
				
				t_p2getucc=$.extend(true,[], getucc);
				return;
			}
			
			var rep='';//存放已完成陣列配對數值
			//取得組合陣列
			function getmlength (olength,lengthb,cut,cutlength,cutall,cutarry,t_same,tspec1,tsize1,t_stlen){
				var t_levellen=dec($('#txtLevel').val()); 
				//原長度,目前長度,本次裁剪長度,可裁剪長度,裁剪樣式,回傳陣列
				if(rep.indexOf("@@")>-1){ //已找到損耗0的組合後續不再處理
					return cutarry;
				}
				
				//可繼續裁剪
				if(tsize1=='3#' || tsize1=='4#' || tsize1 =='5#'){
					if(cut>=0 && ((lengthb-cut)>=t_stlen || (lengthb-cut)==0)//#3~#5 最短定尺條件
					){
						lengthb=lengthb-cut;
						if(cut>0)
							cutall=cutall+(cutall.length>0? ',':'')+cut;
						
						var twrate=dec($('#txtMo').val())/100;
						var twlength=dec($('#txtWaste').val());
						
						//損耗0的組合
						if(lengthb==0){
							cutarry.push({'olength':olength,'cutlength':cutall,'wlenhth':lengthb,'wrate':round(lengthb/olength,4)});
							//if(cutlength.length>25 || cutarry.length>2000) //仍要抓避免 無法 調整最後剩餘數量的最低損耗率
								rep='@@';
							return cutarry;
						}else if (cutarry.length>5000){//#3~#5 沒有損耗 組合筆數過多 直接結束
							var inasknife=false;
							var tminlen=0;
							var tmaxlen=0;
							if(asknife[0]!= undefined){
								tminlen=asknife[asknife.length-1];
								tmaxlen=asknife[0];
							}
							for(var ii=0;ii<asknife.length;ii++){
								if(asknife[ii]==lengthb){
									inasknife=true;
								}
								if(asknife[ii]>=tmaxlen && tmaxlen<=lengthb){
									tmaxlen=asknife[ii];
								}
								if(asknife[asknife.length-1-ii]<=tminlen && tminlen>=lengthb){
									tminlen=asknife[asknife.length-1-ii];
								}
							}
							if(!inasknife){ //非定尺長度進行調整
								if(olength.toString().slice(-2)=='00'){//正常長度
									var t_addlen=tmaxlen-lengthb;
									if(t_levellen>0){
										cutall=cutall+'#'+lengthb;
										cutarry.push({'olength':q_add(olength,t_addlen),'cutlength':cutall,'wlenhth':lengthb,'wrate':round(lengthb/olength,4)});
										rep='@@';
									}
								}else{
									var t_sublen=lengthb-tminlen;
									if(t_levellen>0){
										cutall=cutall+'#'+lengthb;
										cutarry.push({'olength':q_sub(olength,t_sublen),'cutlength':cutall,'wlenhth':lengthb,'wrate':round(lengthb/olength,4)});
										rep='@@';
									}
								}
							}else{
								cutall=cutall+'#'+lengthb;
								cutarry.push({'olength':olength,'cutlength':cutall,'wlenhth':lengthb,'wrate':round(lengthb/olength,4)});
								rep='@@';
							}
							
							return cutarry;
						}else{//繼續裁剪
							var nn=0;
							for(var i=0;i<cutlength.length;i++){
								if(lengthb-cutlength[i]>=0){
									getmlength(olength,lengthb,cutlength[i],cutlength,cutall,cutarry,t_same,tspec1,tsize1,t_stlen);
									nn++;
								}
							}
							//106/08/01 當無法使用正常長度裁剪時才使用圖形可誤差長度裁剪
							if(nn==0){
								for(var i=0;i<t_same.length;i++){
									var tdata=t_same[i].data;
									if(t_same[i].mount>0 && t_same[i].spec==tspec1 && t_same[i].size==tsize1){ //總數量
										for(var j=0;j<tdata.length;j++){
											var ttw03=dec(tdata[j].tw03);
											var tlengthb=t_same[i].lengthb;
											if(tdata[j].mount>0 && lengthb-(tlengthb-ttw03)>=0){//剩餘數量和可誤差裁剪
												getmlength(olength,lengthb,lengthb,cutlength,cutall,cutarry,t_same,tspec1,tsize1,t_stlen);
												nn++;
												break;
											}
										}
									}
								}
							}
							
							if(nn==0){//無法再裁剪>損耗
								//cutall=cutall+'#'+lengthb;
								//cutarry.push({'olength':olength,'cutlength':cutall,'wlenhth':lengthb,'wrate':round(lengthb/olength,4)});
								
								var inasknife=false;
								var tminlen=0;
								var tmaxlen=0;
								if(asknife[0]!= undefined){
									tminlen=asknife[asknife.length-1];
									tmaxlen=asknife[0];
								}
								for(var ii=0;ii<asknife.length;ii++){
									if(asknife[ii]==lengthb){
										inasknife=true;
									}
									if(asknife[ii]>=tmaxlen && tmaxlen<=lengthb){
										tmaxlen=asknife[ii];
									}
									if(asknife[asknife.length-1-ii]<=tminlen && tminlen>=lengthb){
										tminlen=asknife[asknife.length-1-ii];
									}
								}
								if(!inasknife){ //非定尺長度進行調整
									if(olength.toString().slice(-2)=='00'){//正常長度
										var t_addlen=tmaxlen-lengthb;
										if(t_levellen>0){
											cutall=cutall+'#'+lengthb;
											cutarry.push({'olength':q_add(olength,t_addlen),'cutlength':cutall,'wlenhth':lengthb,'wrate':round(lengthb/olength,4)});
										}
									}else{
										var t_sublen=lengthb-tminlen;
										if(t_levellen>0){
											cutall=cutall+'#'+lengthb;
											cutarry.push({'olength':q_sub(olength,t_sublen),'cutlength':cutall,'wlenhth':lengthb,'wrate':round(lengthb/olength,4)});
										}
									}
								}else{
									cutall=cutall+'#'+lengthb;
									cutarry.push({'olength':olength,'cutlength':cutall,'wlenhth':lengthb,'wrate':round(lengthb/olength,4)});
								}
								
								return cutarry;
							}
						}
					}else{//無法再裁剪>損耗
						var inasknife=false;
						var tminlen=0;
						var tmaxlen=0;
						if(asknife[0]!= undefined){
							tminlen=asknife[asknife.length-1];
							tmaxlen=asknife[0];
						}
						for(var ii=0;ii<asknife.length;ii++){
							if(asknife[ii]==lengthb){
								inasknife=true;
							}
							if(asknife[ii]>=tmaxlen && tmaxlen<=lengthb){
								tmaxlen=asknife[ii];
							}
							if(asknife[asknife.length-1-ii]<=tminlen && tminlen>=lengthb){
								tminlen=asknife[asknife.length-1-ii];
							}
						}
						if(!inasknife){ //非定尺長度進行調整
							if(olength.toString().slice(-2)=='00'){//正常長度
								var t_addlen=tmaxlen-lengthb;
								if(t_levellen>0){
									cutall=cutall+'#'+lengthb;
									cutarry.push({'olength':q_add(olength,t_addlen),'cutlength':cutall,'wlenhth':lengthb,'wrate':round(lengthb/olength,4)});
								}
							}else{
								var t_sublen=lengthb-tminlen;
								if(t_levellen>0){
									cutall=cutall+'#'+lengthb;
									cutarry.push({'olength':q_sub(olength,t_sublen),'cutlength':cutall,'wlenhth':lengthb,'wrate':round(lengthb/olength,4)});
								}
							}
						}else{
							cutall=cutall+'#'+lengthb;
							cutarry.push({'olength':olength,'cutlength':cutall,'wlenhth':lengthb,'wrate':round(lengthb/olength,4)});
						}
						
						//cutall=cutall+'#'+lengthb;
						//cutarry.push({'olength':olength,'cutlength':cutall,'wlenhth':lengthb,'wrate':round(lengthb/olength,4)});
						return cutarry;
					}
				}else{ //非#3~#5
					if(cut>=0 && lengthb-cut>=0){
						lengthb=lengthb-cut;
						if(cut>0)
							cutall=cutall+(cutall.length>0? ',':'')+cut;
						
						var twrate=dec($('#txtMo').val())/100;
						var twlength=dec($('#txtWaste').val());
						
						//損耗0的組合
						if(lengthb==0){
							cutarry.push({'olength':olength,'cutlength':cutall,'wlenhth':lengthb,'wrate':round(lengthb/olength,4)});
							//if(cutlength.length>25 || cutarry.length>2000) //仍要抓避免 無法 調整最後剩餘數量的最低損耗率
								rep='@@';
							return cutarry;
						}else//在損耗範圍內組合 
						if (((round(lengthb/olength,4)<=twrate || lengthb<twlength) && cutarry.length>3000) || cutarry.length>5000){
							cutall=cutall+'#'+lengthb;
							cutarry.push({'olength':olength,'cutlength':cutall,'wlenhth':lengthb,'wrate':round(lengthb/olength,4)});
							rep='@@';
							return cutarry;
						}else{//繼續裁剪
							var nn=0;
							for(var i=0;i<cutlength.length;i++){
								if(lengthb-cutlength[i]>=0){
									getmlength(olength,lengthb,cutlength[i],cutlength,cutall,cutarry,t_same,tspec1,tsize1,t_stlen);
									nn++;
								}
							}
							//106/08/01 當無法使用正常長度裁剪時才使用圖形可誤差長度裁剪
							if(nn==0){
								for(var i=0;i<t_same.length;i++){
									var tdata=t_same[i].data;
									if(t_same[i].mount>0 && t_same[i].spec==tspec1 && t_same[i].size==tsize1){ //總數量
										for(var j=0;j<tdata.length;j++){
											var ttw03=dec(tdata[j].tw03);
											var tlengthb=t_same[i].lengthb;
											if(tdata[j].mount>0 && lengthb-(tlengthb-ttw03)>=0){//剩餘數量和可誤差裁剪
												getmlength(olength,lengthb,lengthb,cutlength,cutall,cutarry,t_same,tspec1,tsize1,t_stlen);
												nn++;
												break;
											}
										}
									}
								}
							}
							
							if(nn==0){//無法再裁剪>損耗
								cutall=cutall+'#'+lengthb;
								cutarry.push({'olength':olength,'cutlength':cutall,'wlenhth':lengthb,'wrate':round(lengthb/olength,4)});
								return cutarry;
							}
						}
					}else{//無法再裁剪>損耗
						cutall=cutall+'#'+lengthb;
						cutarry.push({'olength':olength,'cutlength':cutall,'wlenhth':lengthb,'wrate':round(lengthb/olength,4)});
						return cutarry;
					}
					
				}
				return cutarry;
			}
			
			//最小長度限制,已損耗長度,可配對長度,已裁剪長度,暫存裁剪陣列
			function getsortlen(sortlen,wlength,cutlength,cutall,cutarry){
				if(wlength>=sortlen){
					cutarry.push({'wlength':wlength,'cutlength':cutall,'wrate':(wlength-sortlen)});
					return cutarry;
				}else{
					for(var i=0;i<cutlength.length;i++){
						getsortlen(sortlen,wlength+dec(cutlength[i]),cutlength,cutall.toString()+(cutall.toString().length>0?',':'')+cutlength[i],cutarry)
					}
				}
				return cutarry;
			}
			
			//可誤差長度組合
			var ttarray=[],tchglenc=0;
			function samew03length(tcutarray,tspec,tsize,maxlength,maxlength2,tarray){
				if(tarray.length>0){
					var tleng=tarray[0];
					for (var i=0 ;i<tcutarray.length;i++){
						var tspec2=tcutarray[i].spec;
						var tsize2=tcutarray[i].size;
						var tlengthb=dec(tcutarray[i].lengthb);
						var tmount=dec(tcutarray[i].mount);
						var tdata=tcutarray[i].data;
						if(tspec==tspec2 && tsize==tsize2 && tmount>0 && tlengthb==tleng){
							if(tlengthb!=dec(maxlength)){
								for (var j=0 ;j<tdata.length;j++){
									var t_mount=dec(tdata[j].mount);
									var t_tw03=dec(tdata[j].tw03);
									if(t_tw03>0)
										tchglenc=(tchglenc==0?1:tchglenc)*t_tw03;
										
									if(t_mount>0){
										if(ttarray.length==0){
											if(t_tw03==0){
												ttarray.push([tleng]);
											}else{
												ttarray.push([tleng]);
												while(t_tw03>0 && tchglenc<50){
													tleng=tleng-1;
													ttarray.push([tleng]);
													t_tw03--;
												}
											}
										}else{
											var cttarray=$.extend(true,[], ttarray);
											
											for(var k=0;k<ttarray.length;k++){
												ttarray[k]=ttarray[k].concat([tleng]);
											}
											
											while(t_tw03>0 && tchglenc<50){
												tleng=tleng-1;
												for(var k=0;k<cttarray.length;k++){
													ttarray.push(cttarray[k].concat([tleng]));
												}
												t_tw03--;
											}
										}
										break;
									}
								}
							}else{
								if(ttarray.length==0){
									ttarray.push([maxlength2]);
								}else{
									for(var k=0;k<ttarray.length;k++){
										ttarray[k]=ttarray[k].concat([maxlength2]);
									}
								}
							}
							samew03length(tcutarray,tspec,tsize,maxlength,maxlength2,tarray.slice(1));
							break;
						}
					}
				}
				
				return ttarray;
			}
			//長度加權 數量*材切數
			function lengthmount(lenstr,tmp_same,tmaxcutlengthbs){
				var lenarry=lenstr.split('#')[0].split(',');
				var t_group=[];
				for(var i=0;i<lenarry.length;i++){
					var t_n=-1;
					for(var j=0;j<t_group.length;j++){
						if(lenarry[i]==t_group[j].lengthb){
							t_n=j;
							t_group[j].mount=t_group[j].mount+1;
						}
					}
					if(t_n<0){
						t_group.push({
							'lengthb':lenarry[i],
							'mount':1
						});
					}
				}
				
				var tcount=0;
				for(var i=0;i<t_group.length;i++){
					for(var j=0;j<tmaxcutlengthbs.length;j++){
						if(tmaxcutlengthbs[j]==t_group[i].lengthb){
							tcount=t_group[i].mount
							break;
						}
					}
				}
				/*for(var i=0;i<t_group.length;i++){
					for(var j=0;j<tmp_same.length;j++){
						var t_data=tmp_same[j].data;
						for(var k=0;k<t_data.length;k++){
							var t_tw03=t_data[k].tw03;
							var t_mount=t_data[k].mount;
							if(t_mount>0 && (dec(t_group[i].lengthb)==dec(tmp_same[j].lengthb)
							|| dec(tmp_same[j].lengthb)>=dec(t_group[i].lengthb) &&  dec(tmp_same[j].lengthb)-dec(t_tw03)<=dec(t_group[i].lengthb))
							){
								if(dec(tmp_same[j].mount)*dec(t_group[i].mount)>tcount)
									tcount=dec(tmp_same[j].mount)*dec(t_group[i].mount);
								break;
							}
						}
					}
				}*/
				return tcount;
			}
			//長度群組
			function lengthgroup(lenstr){
				var lenarry=lenstr.split('#')[0].split(',');
				var t_group=[];
				for(var i=0;i<lenarry.length;i++){
					var t_n=-1;
					for(var j=0;j<t_group.length;j++){
						if(lenarry[i]==t_group[j]){
							t_n=j
						}
					}
					if(t_n<0){
						t_group.push(lenarry[i]);
					}
				}
				return t_group.length;
			}
			
			function q_gtPost(t_name) {
				switch (t_name) {
					case 'deleUccy':
						var as = _q_appendData("uccy", "", true);
						var err_str = '';
						if (as[0] != undefined) {
							for (var i = 0; i < as.length; i++) {
								if (dec(as[i].gweight) > 0) {
									err_str += as[i].uno + '已領料，不能刪除!!\n';
								}
							}
							if (trim(err_str).length > 0) {
								alert(err_str);
								return;
							} else {
								_btnDele();
							}
						} else {
							_btnDele();
						}
						break;
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
				}
			}

			function q_stPost() {
				if (!(q_cur == 1 || q_cur == 2))
					return false;
				
				//107/02/06 關閉增量模式
				//q_func('qtxt.query.upadprofe', 'cub.txt,upadprofe,' + encodeURI(q_date())+';'+encodeURI('#non')+';'+encodeURI('#non'),r_accy,1);
				if(!emp($('#txtNoa').val())){
					q_func('qtxt.query.autocubufe', 'cub.txt,autocubufe,' + encodeURI($('#txtNoa').val())+';'+encodeURI(q_date()),r_accy,1);
				}
			}

			function q_boxClose(s2) {
				var ret;
				switch (b_pop) {
					case 'workjsfe_b':
						if (q_cur > 0 && q_cur < 4) {
							if (!b_ret || b_ret.length == 0) {
								b_pop = '';
								return;
							}
							
							//107/02/02 表身全部清空
							for (var i = 0; i < q_bbsCount; i++) {
								$('#btnMinus_'+i).click();
							}
							
							//不重覆帶入
							for (var j = 0; j < b_ret.length; j++) {
								for (var i = 0; i < q_bbsCount; i++) {
									var t_ordeno = $('#txtOrdeno_' + i).val();
									var t_no2 = $('#txtNo2_' + i).val();
									if (b_ret[j] && b_ret[j].noa == t_ordeno && b_ret[j].noq == t_no2) {
										b_ret.splice(j, 1);
										j--;
										break;
									}
								}
							}
							
							//處理 是否要彎曲
							for (var j = 0; j < b_ret.length; j++) {
								if(dec(b_ret[j].fold)>0){
									b_ret[j].sale=true;
								}else{
									b_ret[j].sale=false;
								}
							}
							
							if (b_ret && b_ret[0] != undefined) {
								ret = q_gridAddRow(bbsHtm, 'tbbs', 'txtCustno,txtComp,txtProductno,txtProduct,txtScolor,txtOrdeno,txtNo2,txtLengthb,txtWeight,txtMount,txtMemo,txtW01,txtW02,txtDate2,txtW03'
								, b_ret.length, b_ret, 'custno,nick,productno,product,place,noa,noq,lengthb,weight,mount,memo,btol,etol,odate,offlength', 'txtProductno');
								
								for (var i = 0; i < q_bbsCount; i++) {
									for (var j = 0; j < b_ret.length; j++) {
										if($('#txtOrdeno_'+i).val()==b_ret[j].noa && $('#txtNo2_'+i).val()==b_ret[j].noq){
											$('#chkSale_'+i).prop('checked',b_ret[j].sale);
											if(!b_ret[j].sale){
												$('#txtProcessno_'+i).val('');
												$('#txtProcess_'+i).val('');
											}
											break;
										}
									}
								}
							}
							
							bbsreadonly();
							b_ret = '';
						}
						break;
					case q_name + '_s':
						q_boxClose2(s2);
						break;
				}
				b_pop = '';
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;
				q_box('cubfe_s.aspx', q_name + '_s', "500px", "310px", q_getMsg("popSeek"));
			}

			function btnIns() {
				_btnIns();
				$('#txtNoa').val('AUTO');
				$('#txtDatea').val(q_date());
				$('#txtDatea').focus();
				
				$('#txtBdate').val(q_date());
				$('#txtEdate').val(q_cdn(q_date(),7));
				$('#combStatus').val('');
				$('#txtLevel').val(10);
				
				//預設值
				$('#txtM2').val(12);
				$('#txtM3').val(8);
				$('#txtM4').val(6);
				$('#txtM5').val(9);
				$('#txtM6').val(12);
				$('#txtM7').val(15);
				$('#txtM8').val(3);
				$('#txtBdime').val(5);
				$('#txtEdime').val(8);
				$('#txtOdime').val(12);
				$('#txtMo').val(1);
				$('#txtM9').val(0.3);//106/04/20 千分之3
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				$('#txtDatea').focus();
			}

			function btnPrint() {
				q_box('z_cubfep.aspx' + "?;;;noa=" + trim($('#txtNoa').val()) + ";" + r_accy, '', "95%", "95%", q_getMsg("popPrint"));
			}

			function btnOk() {
				if ($('#txtDatea').val().length == 0 || !q_cd($('#txtDatea').val())) {
					alert(q_getMsg('lblDatea') + '錯誤。');
					return;
				}
				
				var t_err='';
				//檢查bbt
				for (var j = 0; j < q_bbtCount; j++) {
					if(!emp($('#txtProductno__'+j).val()) && !emp($('#txtProduct__'+j).val()) &&!emp($('#txtMemo2__'+j).val()) &&!emp($('#txtNor__'+j).val())){
						var tproduct=$('#txtProduct__'+j).val();
						var tmount=dec($('#txtGmount__'+j).val());//領料數量
						//材質號數長度
						var tspec=tproduct.substr(tproduct.indexOf('S'),tproduct.indexOf(' ')-tproduct.indexOf('S'))
						var tsize=tproduct.split(' ')[1].split('*')[0];
						var tlength=dec(tproduct.split('*')[1])*100;
						var t_memo2s=replaceAll('+'+$('#txtMemo2__'+j).val().substr(0,$('#txtMemo2__'+j).val().indexOf('=')),'(入庫)','');
						var t_memo2=replaceAll($('#txtMemo2__'+j).val().substr(0,$('#txtMemo2__'+j).val().indexOf('=')),'(入庫)','').split('+');
						var t_nor=$('#txtNor__'+j).val().split(',');
						var lengthc=dec($('#txtLengthc__'+j).val());//損耗
						var chklength=0;
						for(var k=0;k<t_memo2.length;k++){
							var clength=dec(t_memo2[k].split('*')[0]);
							var cmount=dec(t_memo2[k].split('*')[1]);
							chklength=q_add(chklength,q_mul(clength,cmount));
						}
						if(q_add(chklength,lengthc)!=tlength && q_add(chklength,lengthc)!=(tlength+dec($('#txtLevel').val()))){
							if(tlength>chklength){
								t_err=t_err+'領料 第'+(j+1)+'項 領料長度('+tlength.toString()+')大於裁剪總長度('+chklength.toString()+')+損耗('+lengthc+')!! \n';
							}else{
								t_err=t_err+'領料 第'+(j+1)+'項 領料長度('+tlength.toString()+')小於裁剪總長度('+chklength.toString()+')+損耗('+lengthc+')!! \n';
							}
						}
						for(var k=0;k<t_nor.length;k++){
							if(dec($('#txtW03_'+(dec(t_nor[k])-1)).val())>0){ //可誤差長度
								var tw03=dec($('#txtW03_'+(dec(t_nor[k])-1)).val());
								var istw03len=false;
								if(t_memo2s.indexOf('+'+dec($('#txtLengthb_'+(dec(t_nor[k])-1)).val())+'*')>-1){
									istw03len=true;
								}
								var tlen=dec($('#txtLengthb_'+(dec(t_nor[k])-1)).val());
								while(tw03>0){
									tlen--;
									if(t_memo2s.indexOf('+'+tlen+'*')==-1){
										istw03len=true;
									}
									tw03--;
								}
								
								if(!istw03len){
									t_err=t_err+'領料 第'+(j+1)+'項 裁剪內容('+t_memo2s.substr(1)+')不存在配料項次【'+t_nor[k]+'】長度('+$('#txtLengthb_'+(dec(t_nor[k])-1)).val()+')!! \n';
									break;
								}
								
							}else{
								if(t_memo2s.indexOf('+'+dec($('#txtLengthb_'+(dec(t_nor[k])-1)).val())+'*')==-1){
									t_err=t_err+'領料 第'+(j+1)+'項 裁剪內容('+t_memo2s.substr(1)+')不存在配料項次【'+t_nor[k]+'】長度('+$('#txtLengthb_'+(dec(t_nor[k])-1)).val()+')!! \n';
									break;
								}
							}
						}
					}
				}
				if(t_err.length>0){
					alert(t_err);
					//return;
				}
				t_err='';
				var t_same=[];
				//相同材質號數長度合併
				for (var i = 0; i < q_bbsCount; i++) {
					if(!emp($('#txtProductno_'+i).val()) && !emp($('#txtProduct_'+i).val()) 
					&& ($('#txtProduct_'+i).val().indexOf('鋼筋')>-1|| $('#txtProduct_'+i).val().indexOf('螺栓')>-1)){
						var tproduct=$('#txtProduct_'+i).val();
						var tmount=dec($('#txtMount_'+i).val());//裁剪數量
						//材質號數長度
						var tspec='';
						var tsize='';
						if(tproduct.indexOf('螺栓')>-1){
							tspec='SD420W';
							tsize=replaceAll(replaceAll(tproduct.split('#')[0]+'#','基礎螺栓',''),'抗震專利','');
						}else{ //鋼筋
							tspec=tproduct.substr(tproduct.indexOf('S'),tproduct.indexOf(' ')-tproduct.indexOf('S'));
							tsize=tproduct.split(' ')[1].split('*')[0];
						}
						var tlength=dec($('#txtLengthb_'+i).val());
						var twaste=dec($('#txtWaste').val()); //容許損耗長度
						var tmo=dec($('#txtMo').val()); //容許損耗%
						var tw03=dec($('#txtW03_'+i).val());// 圖形可誤差長度
						
						var t_j=-1;
						for (var j=0;j<t_same.length;j++){
							if(t_same[j].spec==tspec && t_same[j].size==tsize && t_same[j].lengthb==tlength){
								t_j=j;
								t_same[j].data.push({
									'nor':i+1,
									'mount':tmount,
									'tw03':tw03
								})
								t_same[j].mount=t_same[j].mount+tmount;
								break;
							}
						}
						
						if(t_j<0){
							t_same.push({
								'spec':tspec,
								'size':tsize,
								'lengthb':tlength,
								'mount':tmount,
								'data':[{
									'nor':i+1,
									'mount':tmount,
									'tw03':tw03
								}]
							});
						}
					}
				}
				
				/*for (var i=0;i<t_same.length;i++){
					//數量少的先裁剪
					t_same[i].data.sort(function(a, b) {if(a.mount>b.mount) {return 1;} if (a.mount < b.mount) {return -1;} return 0;});
				}*/
				
				//判斷領料裁剪出的數量是否符合裁剪單的資料
				for (var j = 0; j < q_bbtCount; j++) {
					if(!emp($('#txtProductno__'+j).val()) && !emp($('#txtProduct__'+j).val()) &&!emp($('#txtMemo2__'+j).val()) &&!emp($('#txtNor__'+j).val())){
						var tproduct=$('#txtProduct__'+j).val();
						var tmount=dec($('#txtGmount__'+j).val());//領料數量
						//材質號數長度
						var tspec=tproduct.substr(tproduct.indexOf('S'),tproduct.indexOf(' ')-tproduct.indexOf('S'));
						var tsize=tproduct.split(' ')[1].split('*')[0];
						var tlength=dec(tproduct.split('*')[1])*100;
						var t_memo2=replaceAll($('#txtMemo2__'+j).val().substr(0,$('#txtMemo2__'+j).val().indexOf('=')),'(入庫)','').split('+');
						var t_nor=$('#txtNor__'+j).val().split(','); //107/01/23 按順項次扣料必免提前扣料
						var t_lengthc=$('#txtLengthc__'+j).val();
						var t_werr=false;
						for(var k=0;k<t_memo2.length;k++){
							var clength=dec(t_memo2[k].split('*')[0]);
							var cmount=q_mul(dec(t_memo2[k].split('*')[1]),tmount);
							for(var o=0;o<t_nor.length;o++){
								for (var i=0;i<t_same.length;i++){
									for (var n=0;n<t_same[i].data.length;n++){
										if(t_same[i].spec==tspec && t_same[i].size==tsize 
											&& (t_same[i].lengthb==clength || (dec(t_same[i].lengthb)>=dec(clength) && dec(t_same[i].lengthb)-dec(t_same[i].data[n].tw03)<=dec(clength)))
											&& t_nor[o]==t_same[i].data[n].nor.toString() && cmount>0
										){
											var t_ccmount=0;
											if(((t_lengthc>twaste && twaste>0) 
											|| (t_lengthc>tmo*tlength && tmo>0)) && !t_werr){
												t_err=t_err+'領料 第'+(j+1)+'項 裁剪組料損耗('+t_lengthc+') 超出訂單可損耗長度!! \n';
												t_werr=true;
											}
												
											if(t_same[i].data[n].mount>=cmount){
												t_ccmount=cmount;
												t_same[i].data[n].mount=t_same[i].data[n].mount-cmount;
												cmount=0;
											}else{
												t_ccmount=t_same[i].data[n].mount;
												cmount=cmount-t_same[i].data[n].mount;
												t_same[i].data[n].mount=0;
											}
											t_same[i].mount=t_same[i].mount-t_ccmount;
										}
									}
								}
							}
						}
					}
				}
				
				for (var i=0;i<t_same.length;i++){
					if(t_same[i].mount>0){
						for (var j=0;j<t_same[i].data.length;j++){
							if(t_same[i].data[j].mount>0){
								t_err=t_err+'裁剪 第'+t_same[i].data[j].nor+'項 長度'+t_same[i].lengthb+' 數量尚有'+t_same[i].data[j].mount+'支未裁剪!! \n';
							}
						}
					}
				}
				
				if(t_err.length>0 && dec($('#txtIdime').val())==0){
					alert(t_err);
					//return;
				}
				
				if($('#combStatus').val()!=null){
					$('#txtStatus').val($('#combStatus').val().toString());
				}
				sum();
				if(q_cur==1)
					$('#txtWorker').val(r_name);
				else
					$('#txtWorker2').val(r_name);

				var t_noa = trim($('#txtNoa').val());
				var t_date = trim($('#txtDatea').val());
				if (t_noa.length == 0 || t_noa == "AUTO")
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_cub') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
				else
					wrServer(t_noa);
			}

			function wrServer(key_value) {
				var i;
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
			}

			function bbsSave(as) {
				if (!as['productno'] && !as['product']) {
					as[bbsKey[1]] = '';
					return;
				}
				q_nowf();
				as['noa'] = abbm2['noa'];
				return true;
			}

			function bbtSave(as) {
				if (!as['uno'] && !as['productno'] && !as['product']) {
					as[bbtKey[1]] = '';
					return;
				}
				q_nowf();
				return true;
			}

			function refresh(recno) {
				_refresh(recno);
				
				$('#combStatus').val($('#txtStatus').val().split(','));
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				if(t_para){
					$('#btnCubu').removeAttr('disabled');
					$('#combStatus').attr('disabled','disabled');
				}else{
					$('#btnCubu').attr('disabled','disabled');
					$('#combStatus').removeAttr('disabled');
				}
				bbsreadonly();
			}

			function btnMinus(id) {
				_btnMinus(id);
			}

			function btnPlus(org_htm, dest_tag, afield) {
				_btnPlus(org_htm, dest_tag, afield);
			}

			function btnPlut(org_htm, dest_tag, afield) {
				_btnPlus(org_htm, dest_tag, afield);
			}

			function bbsAssign() {
				for (var i = 0; i < q_bbsCount; i++) {
					$('#lblNo_' + i).text(i + 1);
					if (!$('#btnMinus_' + i).hasClass('isAssign')) {
					}
				}
				_bbsAssign();
				bbsreadonly();
				
				$('#lblMech').text('裁剪機台');
				$('#lblSpec').text('材質');
				$('#lblM1').text('號數');
				$('#lblMo').text('容許損耗%');
				$('#lblWaste').text('容許損耗長度');
				$('#lblC1').text('總損耗長度');
				$('#lblCustno_s').text('客戶');
				$('#lblProductno_s').text('品號');
				$('#lblProduct_s').text('品名');
				$('#lblSpec_s').text('材質');
				$('#lblSize_s').text('號數');
				$('#lblLengthb_s').text('裁剪長度');
				$('#lblMount_s').text('訂單數量');
				$('#lblWeight_s').text('訂單重量');
				$('#lblNeed_s').text('需求');
				$('#lblMemo_s').text('備註');
				$('#lblDate2_s').text('預交日');
				$('#lblEnda_s').text('完工');
				$('#lblOrdeno_s').text('加工單號');
				$('#lblNo2_s').text('序號');
				$('#lblPrice_s').text('單價');
				$('#lblDatea_s').text('預定出貨日期');
				$('#lblUnit_s').text('單位');
				$('#lblW01_s').text('容許公差+/-');
				$('#lblW03_s').text('圖形可誤差長度');//106/04/20
				//$('#lblW04_s').text('容許損耗%');
				$('#btnWorkjImport').val('1 = 加工單匯入');
				$('#btnUcccstk').val('2 = 電腦配料');
				$('#lblStatus').text('板料可用長度');
				$('#btnStk').val('庫存量');
				//$('#lblW05_s').text('庫存數量');
				//$('#lblW06_s').text('安全存量');
				//$('#lblW07_s').text('裁剪數量');
				$('#lblScolor_s').text('位置');
				$('#lblMech_s').text('指定彎曲機台');
				$('#lblSale_s').text('彎曲');
				$('#lblStoreno').text('中料倉庫');
				$('#lblWorkjno').text('加工單號');
			}

			function distinct(arr1) {
				var uniArray = [];
				for (var i = 0; i < arr1.length; i++) {
					var val = arr1[i];
					if ($.inArray(val, uniArray) === -1) {
						uniArray.push(val);
					}
				}
				return uniArray;
			}

			function getBBTWhere(objname) {
				var tempArray = new Array();
				for (var j = 0; j < q_bbtCount; j++) {
					tempArray.push($('#txt' + objname + '__' + j).val());
				}
				var TmpStr = distinct(tempArray).sort();
				TmpStr = TmpStr.toString().replace(/,/g, "','").replace(/^/, "'").replace(/$/, "'");
				return TmpStr;
			}

			function bbtAssign() {
				for (var i = 0; i < q_bbtCount; i++) {
					$('#lblNo__' + i).text(i + 1);
					if (!$('#btnMinut__' + i).hasClass('isAssign')) {
						$('#txtGmount__'+i).change(function() {
							sum();
						});
						$('#txtLengthc__'+i).change(function() {
							sum();
						});
					}
				}
				_bbtAssign();
				bbsreadonly();
				$('#lblUno_t').text('領料批號');
				$('#lblProductno_t').text('領料品號');
				$('#lblProduct_t').text('領料品名');
				$('#lblSpec_t').text('規格');
				$('#lblSize_t').text('號數');
				$('#lblLengthb_t').text('長度');
				$('#lblGmount_t').text('領料數量');
				$('#lblGweight_t').text('領料重量');
				$('#lblStore_t').text('領料倉');
				$('#lblMemo_t').text('備註');
				$('#lblUnit_t').text('單位');
				$('#lblNor_t').text('配料項次');
				$('#lblMemo2_t').html('裁剪內容/支(裁剪長度*數量+...)');
				$('#lblLengthc_t').text('損耗長度/支');
				//$('#lblScolor_t').html('基礎螺栓餘料裁剪內容<br>(裁剪長度*數量+...)');
				//$('#lblHard_t').text('基礎螺栓扣除餘料長度');
				
				$('#btnCutmerge').unbind('click')
				$('#btnCutmerge').click(function(e) {
					$('#div_cutmerge').html('');
					var cutmerge=[];
					for (var i = 0; i < q_bbtCount; i++) {
						if(!emp($('#txtMemo2__'+i).val()) && !emp($('#txtProduct__'+i).val())){
							var t_n=-1;
							for (var j = 0; j < cutmerge.length; j++) {
								if($('#txtMemo2__'+i).val()==cutmerge[j].memo2 && $('#txtProduct__'+i).val()==cutmerge[j].product){
									t_n=j;
									cutmerge[j].mount=q_add(dec(cutmerge[j].mount),dec($('#txtGmount__'+i).val()));
									cutmerge[j].weight=q_add(dec(cutmerge[j].weight),dec($('#txtGweight__'+i).val()));
									cutmerge[j].nor=cutmerge[j].nor+'#'+$('#txtNor__'+i).val();
									break;
								}
							}
							if(t_n==-1){
								cutmerge.push({
									product:$('#txtProduct__'+i).val(),
									memo2:$('#txtMemo2__'+i).val(),
									mount:$('#txtGmount__'+i).val(),
									weight:$('#txtGweight__'+i).val(),
									nor:$('#txtNor__'+i).val()
								})
							}
						}
					}
					if(cutmerge.length>0){
						var thtml="<table border='1' cellpadding='2' cellspacing='0' style='width:100%;'>";
						thtml+="<tr><td style='width:270px;'>領料品名</td>";
						thtml+="<td style='width:100px;'>領料數量</td>";
						thtml+="<td style='width:100px;'>領料重量</td>";
						thtml+="<td style='width:330px;'>裁剪內容</td></tr>";
						for (var j = 0; j < cutmerge.length; j++) {
							thtml+="<tr><td>"+cutmerge[j].product+"</td>";
							thtml+="<td style='text-align: right;'>"+cutmerge[j].mount+"</td>";
							thtml+="<td style='text-align: right;'>"+cutmerge[j].weight+"</td>";
							thtml+="<td>"+cutmerge[j].memo2+"</td></tr>";
						}
						thtml+="<tr><td colspan='4' style='text-align:center;'><input id='btnCutmergeclose' type='button' value='關閉'></td></tr>";
						thtml+="</table>";
						$('#div_cutmerge').html(thtml);
						$('#btnCutmergeclose').click(function() {
							$('#div_cutmerge').hide();
						});
						$('#div_cutmerge').css('top',e.pageY);
						$('#div_cutmerge').css('left',e.pageX-parseInt($('#div_cutmerge').css('width')));
						$('#div_cutmerge').show();
					}
				});
				$('#btnAddcut').unbind('click')
				$('#btnAddcut').click(function(e) {
					$('#div_addcut').html('');
					var t_same=[]; //bbs可裁剪的內容(相同材質號數長度)
					for (var i = 0; i < q_bbsCount; i++) {
						if(!emp($('#txtProduct_'+i).val()) //!emp($('#txtProductno_'+i).val()) && 
						&& ($('#txtProduct_'+i).val().indexOf('鋼筋')>-1 || $('#txtProduct_'+i).val().indexOf('螺栓')>-1)){
							var tproduct=$('#txtProduct_'+i).val();
							var tmount=dec($('#txtMount_'+i).val());//裁剪數量
							//材質號數長度
							var tspec='';
							var tsize='';
							if(tproduct.indexOf('螺栓')>-1){
								tspec='SD420W';
								tsize=replaceAll(replaceAll(tproduct.split('#')[0]+'#','基礎螺栓',''),'抗震專利','');
							}else{ //鋼筋
								tspec=tproduct.substr(tproduct.indexOf('S'),tproduct.indexOf(' ')-tproduct.indexOf('S'));
								tsize=tproduct.split(' ')[1].split('*')[0];
							}
							var tlength=dec($('#txtLengthb_'+i).val());
							var tw03=dec($('#txtW03_'+i).val());
							t_same.push({
								'product':tproduct,
								'nor':i+1,
								'spec':tspec,
								'size':tsize,
								'lengthb':tlength,
								'mount':tmount,
								'tw03':tw03
							});
						}
					}
					
					var t_morecut=[];
					for (var j = 0; j < q_bbtCount; j++) {
						if(!emp($('#txtProduct__'+j).val()) &&!emp($('#txtMemo2__'+j).val()) &&!emp($('#txtNor__'+j).val())){ //!emp($('#txtProductno__'+j).val()) &&
							var tproduct=$('#txtProduct__'+j).val();
							var tmount=dec($('#txtGmount__'+j).val());//領料數量
							//材質號數長度
							var tspec=tproduct.substr(tproduct.indexOf('S'),tproduct.indexOf(' ')-tproduct.indexOf('S'));
							var tsize=tproduct.split(' ')[1].split('*')[0];
							var tlength=dec(tproduct.split('*')[1])*100;
							var t_memo2=replaceAll($('#txtMemo2__'+j).val().substr(0,$('#txtMemo2__'+j).val().indexOf('=')),'(入庫)','').split('+');
							var t_nor=','+$('#txtNor__'+j).val()+',';
							var t_lengthc=$('#txtLengthc__'+j).val();
							for(var k=0;k<t_memo2.length;k++){
								var clength=dec(t_memo2[k].split('*')[0]);
								var cmount=q_mul(dec(t_memo2[k].split('*')[1]),tmount);
								var existlength=false;
								for (var i=0;i<t_same.length;i++){
									if(t_same[i].spec==tspec && t_same[i].size==tsize && (t_same[i].lengthb==clength || (dec(t_same[i].lengthb)>=dec(clength) && dec(t_same[i].lengthb)-dec(t_same[i].tw03)<=dec(clength)))){
										if(t_nor.indexOf(','+t_same[i].nor.toString()+',')>-1 && dec(t_same[i].mount)>0 && cmount>0){
											if(dec(t_same[i].mount)>=cmount){
												t_same[i].mount=t_same[i].mount-cmount;
												cmount=0;
											}else{
												cmount=cmount-dec(t_same[i].mount);
												t_same[i].mount=0;
											}
												
										}
										existlength=true;
									}
								}
								if(!existlength){
									cmount=0;
								}
								if(cmount>0){
									var t_n=-1;
									for(var x=0;x<t_morecut.length;x++){
										if(t_morecut[x].lengthb==clength){
											t_n=j;
											t_morecut[x].mount=q_add(dec(t_morecut[x].mount),cmount);
											break;
										}	
									}
									if(t_n<0){
										t_morecut.push({
											'lengthb':clength,
											'mount':dec(cmount),
										});
									}
								}
							}
						}
					}
					
					/*for (var i=0;i<t_same.length;i++){
						if(t_same[i].mount<0){
							var t_n=-1;
							for(var j=0;j<t_morecut.length;j++){
								if(t_morecut[j].lengthb==t_same[i].lengthb){
									t_n=j;
									t_morecut[j].mount=q_add(dec(t_morecut[j].mount),Math.abs(dec(t_same[i].mount)));
									break;
								}	
							}
							if(t_n<0){
								t_morecut.push({
									'lengthb':t_same[i].lengthb,
									'mount':Math.abs(dec(t_same[i].mount)),
								});
							}
						}
					}*/
					if(t_morecut.length>0){
						var thtml="<table border='1' cellpadding='2' cellspacing='0' style='width:100%;'>";
						thtml+="<tr><td style='width:100px;'>裁剪長度</td>";
						thtml+="<td style='width:100px;'>多配數量</td>";
						for (var j = 0; j < t_morecut.length; j++) {
							thtml+="<tr><td style='text-align: center;'>"+t_morecut[j].lengthb+"</td>";
							thtml+="<td style='text-align: right;'>"+t_morecut[j].mount+"</td>";
						}
						thtml+="<tr><td colspan='4' style='text-align:center;'><input id='btnAddcutclose' type='button' value='關閉'></td></tr>";
						thtml+="</table>";
						$('#div_addcut').html(thtml);
						$('#btnAddcutclose').click(function() {
							$('#div_addcut').hide();
						});
						$('#div_addcut').css('top',e.pageY);
						$('#div_addcut').css('left',e.pageX-parseInt($('#div_addcut').css('width')));
						$('#div_addcut').show();
					}
					
				});
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
				var t_where = 'where=^^ uno in(' + getBBTWhere('Uno') + ') ^^';
				q_gt('uccy', t_where, 0, 0, 0, 'deleUccy', r_accy);
			}

			function btnCancel() {
				_btnCancel();
			}

			function onPageError(error) {
				alert("An error occurred:\r\n" + error.Message);
			}

			function q_popPost(id) {
				switch (id) {
					case 'txtProductno_':
						bbsreadonly();
						break;
					default:
						break;
				}
			}
			
			function bbsreadonly() {
				for (var j = 0; j < q_bbsCount; j++) {
					var t_productno=$('#txtProductno_'+j).val();
					var t_ordeno=$('#txtOrdeno_'+j).val();
					var t_product=$('#txtProduct_'+j).val();
					$('#chkSale_'+j).attr('disabled','disabled')
					if($('#chkSale_'+j).prop('checked')){
						if(q_cur==1 || q_cur==2){
							$('#txtProcessno_'+j).removeAttr('disabled');
						}
					}else{
						$('#txtProcessno_'+j).attr('disabled','disabled');
					}
					if(t_ordeno.length>0){
						if(q_cur==1 || q_cur==2){
							$('#txtProductno_'+j).attr('disabled','disabled');
							$('#txtLengthb_'+j).attr('disabled','disabled');
							$('#txtMount_'+j).attr('disabled','disabled');
							$('#txtWeight_'+j).attr('disabled','disabled');
						}
					}else{
						if(q_cur==1 || q_cur==2){
							$('#txtProcessno_'+j).removeAttr('disabled');
							$('#txtLengthb_'+j).removeAttr('disabled');
							$('#txtMount_'+j).removeAttr('disabled');
							$('#txtWeight_'+j).removeAttr('disabled');
						}
					}
				}
			}
			
			//107/01/08 數量少
			function getp4 (){
				var t_err='';
				//---------------------------------------------------------------
				var t_sortlen=0;//最短裁剪限制長度
				q_gt('mech', "where=^^noa='"+$('#cmbMechno').val()+"'^^" , 0, 0, 0, "getmech",r_accy,1); //號數
				var as = _q_appendData("mech", "", true);
				if (as[0] != undefined) {
					t_sortlen=as[0].dime1;
				}
				
				var t_cutsheet=$('#combStatus').val();//可裁剪的板料長度
				var maxcutsheet=0;//最大板料長度
				if($('#combStatus').find("option:selected").text().length==0){
					t_cutsheet='12';
					t_cutsheet=t_cutsheet.split(',');
				}
				for (var i = 0; i < t_cutsheet.length; i++) {
					if(maxcutsheet<dec(t_cutsheet[i])*100){
						maxcutsheet=dec(t_cutsheet[i])*100;
					}
				}
				
				//106/03/23 已最大版料先下去配料
				t_cutsheet.sort(function(a, b) {if(a>b) {return -1;} if (a < b) {return 1;} return 0;})
				//---------------------------------------------------------------
				
				//相同材質號數長度合併
				//105/08/25 基礎螺栓 不用餘料裁剪 一起帶入組合裁剪 SD420W
				//105/08/25 安全存量 連同帶入表身資料
				var t_same=[]; //bbs可裁剪的內容(相同材質號數長度)
				for (var i = 0; i < q_bbsCount; i++) {
					if(!emp($('#txtProductno_'+i).val()) && !emp($('#txtProduct_'+i).val()) 
					&& ($('#txtProduct_'+i).val().indexOf('鋼筋')>-1 || $('#txtProduct_'+i).val().indexOf('螺栓')>-1)
					&& dec($('#txtLengthb_'+i).val())<=maxcutsheet){
						var tproduct=$('#txtProduct_'+i).val();
						var tmount=dec($('#txtMount_'+i).val());//裁剪數量
						//材質號數長度
						var tspec='';
						var tsize='';
						if(tproduct.indexOf('螺栓')>-1){
							tspec='SD420W';
							tsize=replaceAll(replaceAll(tproduct.split('#')[0]+'#','基礎螺栓',''),'抗震專利','');
						}else{ //鋼筋
							tspec=tproduct.substr(tproduct.indexOf('S'),tproduct.indexOf(' ')-tproduct.indexOf('S'));
							tsize=tproduct.split(' ')[1].split('*')[0];
						}
						var tlength=dec($('#txtLengthb_'+i).val());
						var twaste=dec($('#txtWaste').val()); //容許損耗長度
						var to=dec($('#txtMo').val()); //容許損耗%
						var tw03=dec($('#txtW03_'+i).val());// 圖形可誤差長度
							
						var t_j=-1;
						for (var j=0;j<t_same.length;j++){
							if(t_same[j].spec==tspec && t_same[j].size==tsize && t_same[j].lengthb==tlength){
								t_j=j;
								t_same[j].data.push({
									'nor':i,
									'mount':tmount,
									'tw03':tw03
								})
								t_same[j].mount=t_same[j].mount+tmount;
								break;
							}
						}
						
						if(t_j<0){
							t_same.push({
								'spec':tspec,
								'size':tsize,
								'lengthb':tlength,
								'mount':tmount,
								'data':[{
									'nor':i,
									'mount':tmount,
									'tw03':tw03
								}]
							});
						}
					}
				}
				
				var t_m9=dec($('#txtM9').val());
				if(t_m9<=0 || t_m9==undefined)
					t_m9=0;
				for (var i=0;i<t_same.length;i++){
					t_same[i].maxmount=round(t_same[i].mount*(t_m9/100),0);
				}
				
				//107/01/26加入可補足安全存量(非領用) //107/02/06 取消增量模式
				for (var i=0;i<safeas.length;i++){
					for (var j=0;j<t_same.length;j++){
						if(safeas[i].spec==t_same[j].spec && safeas[i].size==t_same[j].size && safeas[i].lengthb==t_same[j].lengthb){
							var t_mount=dec(safeas[i].addsafe);//-dec(safeas[i].mount);
							t_same[j].maxmount=q_add(dec(t_same[j].maxmount),t_mount);
						}
					}
				}
				
				var getucc=[];
				
				//107/01/31 排除可直接使用安全庫存
				for (var j=0;j<t_same.length;j++){
					for (var i=0;i<safehas.length;i++){
						if(safehas[i].spec==t_same[j].spec && safehas[i].size==t_same[j].size && safehas[i].lengthb==t_same[j].lengthb){
							if(t_same[j].mount<=safehas[i].smount){ //全部使用安全存量
								var t_nor='',t_noras=[];
								for (var k=0;k<t_same[j].data.length;k++){
									t_nor+=(t_nor.length>0?",":'')+(t_same[j].data[k].nor+1).toString();
									t_noras.push({
										'nor':t_same[j].data[k].nor+1,
										'mount':t_same[j].mount
									});
								}
								getucc.push({
									'spec':t_same[j].spec,
									'size':t_same[j].size,
									'lengthb':t_same[j].lengthb,
									'wlengthb':0,
									'mount':t_same[j].mount,
									'usemaxmount':t_same[j].maxmount,
									'nor':t_nor,
									'noras':t_noras,
									'cutlen':[t_same[j].lengthb],
									'data':[{'lengthb':t_same[j].lengthb,'mount':t_same[j].mount}],
									'typea':'s'
								});
								t_same.splice(j, 1);
								j--;
							}else{//部分
								var t_nor='',t_noras=[],t_smount=safehas[i].smount;
								for (var k=0;k<t_same[j].data.length;k++){
									if(t_smount>0 && t_same[j].data[k].mount>0){
										t_nor+=(t_nor.length>0?",":'')+(t_same[j].data[k].nor+1).toString();
										if(t_smount>=t_same[j].data[k].mount){
											t_noras.push({
												'nor':t_same[j].data[k].nor+1,
												'mount':t_same[j].data[k].mount
											});
											
											t_smount=t_smount-t_same[j].data[k].mount;
											t_same[j].mount=t_same[j].mount-t_same[j].data[k].mount
											t_same[j].data[k].mount=0;
											t_same[j].data.splice(k, 1);
											k--;
										}else{
											t_noras.push({
												'nor':t_same[j].data[k].nor+1,
												'mount':t_smount
											});
											
											t_same[j].data[k].mount=t_same[j].data[k].mount-t_smount;
											t_same[j].mount=t_same[j].mount-t_smount;
											t_smount=0;
										}
									}
								}
								
								getucc.push({
									'spec':t_same[j].spec,
									'size':t_same[j].size,
									'lengthb':t_same[j].lengthb,
									'wlengthb':0,
									'mount':safehas[i].smount,
									'usemaxmount':t_same[j].maxmount,
									'nor':t_nor,
									'noras':t_noras,
									'cutlen':[t_same[j].lengthb],
									'data':[{'lengthb':t_same[j].lengthb,'mount':safehas[i].smount}],
									'typea':'s'
								});
							}
							break;
						}
					}
				}
									
				//推算選料
				//先裁剪最大長度
				t_same.sort(function(a, b) {if(a.lengthb>b.lengthb) {return -1;} if (a.lengthb < b.lengthb) {return 1;} return 0;});
				for (var i=0;i<t_same.length;i++){
					//數量少的先裁剪
					t_same[i].data.sort(function(a, b) {if(a.mount>b.mount) {return 1;} if (a.mount < b.mount) {return -1;} return 0;});
				}
				
				var specsize='';//存放已做的材質和號數
				var as_add5=[];//暫存可使用板料長度
				var t_stlen=50; //取最小定尺尺寸
				for (var i=0;i<t_same.length;i++){
					var sheetlength=''; //板料可用長度
					//材質號數
					var tspec1=t_same[i].spec;
					var tsize1=t_same[i].size;
					//取得設定可使用的板料長度
					var add5n=-1;
					for(var x5n=0;x5n<as_add5.length;x5n++){
						if(as_add5[x5n].size==tsize1){
							add5n=x5n;
							break;
						}
					}
					
					if(as_add5.length>0 && add5n!=-1){
						sheetlength=as_add5[0].sheetlength;
					}else{
						q_gt('add5', "where=^^typea='"+tsize1+"'^^" , 0, 0, 0, "getadd5",r_accy,1); //號數
						var as = _q_appendData("add5s", "", true);
						for (var j=0;j<as.length;j++){
							sheetlength=sheetlength+as[j].postno+',';
						}
						
						as_add5.push({
							'size':tsize1,
							'sheetlength':sheetlength
						});
					}
					
					if(tsize1=='3#' || tsize1=='4#' || tsize1=='5#'){
						//取最小定尺尺寸
						if(t_same[0]!= undefined){
							q_gt('adknife', "where=^^ style='"+t_same[0].size+"'^^", 0, 0, 0, "getadknife",r_accy,1);
							var as = _q_appendData("adknife", "", true);
							if(as[0]!= undefined){
								if(as[0].memo.length>0){
									t_stlen=dec(replaceAll(as[0].memo.split('/')[0],'cm',''));
									asknife=replaceAll(as[0].memo,'cm','').split('/');
								}
							}
						}
						for(var j=0;j<asknife.length;j++){
							if(asknife[j]==''){
								asknife.splice(j, 1);
								j--;
							}else{
								asknife[j]=dec(asknife[j]);
							}
						}
					}
					
					if(specsize.indexOf(tspec1+tsize1+'#')==-1){//已做過的相同材質號數 不在做一次
						specsize=specsize+tspec1+tsize1+'#';
						var cutlengthb=[];//相同材質號數的長度
						var cutlengthballs=[];//相同材質號數的長度內 根據最大長度 可誤差長度
						var maxcutlengthb='0'; //最大長度
						var maxcutlengthbs=[];//最大長度可誤差長度
						
						//讀取相同材質號數的長度
						cutlengthb=[];
						cutlengthballs=[];
						maxcutlengthb='0';
						maxcutlengthbs=[];
						
						var t_cutlengthb=[];
						for (var j=0;j<t_same.length;j++){
							var tspec2=t_same[j].spec;
							var tsize2=t_same[j].size;
							var tmount2=t_same[j].mount;
							var lengthb2=dec(t_same[j].lengthb);
							if(tspec1==tspec2 && tsize1==tsize2 && dec(tmount2)>0){
								t_cutlengthb.push({
									'lengthb':lengthb2,
									'mount':tmount2
								});
							}
						}
						t_cutlengthb.sort(function(a, b) {if(a.mount>b.mount) {return 1;} if (a.mount < b.mount) {return -1;} if(a.lengthb>b.lengthb) {return 1;} if (a.lengthb < b.lengthb) {return -1;} return 0;});
						for (var j=0;j<t_cutlengthb.length;j++){
							cutlengthb.push(t_cutlengthb[j].lengthb);
						}
						maxcutlengthb=cutlengthb[0];
						//----------------------------------------------------------------------
						
						//裁切組合
						var t_cups=[];
						var t_cupsp=false;
						while(cutlengthb.length>0){//已排序過 
							//106/04/24一個項次裁剪完，再重新取得組合 求得最小損耗
							//106/09/14 不受項次限制
							t_cups=[];
							//可變動長度b-------------------------------------------------------
							maxcutlengthbs=[];
							cutlengthballs=[];
							for (var j=0;j<t_same.length;j++){
								var tspec2=t_same[j].spec;
								var tsize2=t_same[j].size;
								var lengthb2=dec(t_same[j].lengthb);
								if(tspec1==tspec2 && tsize1==tsize2 && lengthb2==maxcutlengthb){
									maxcutlengthbs.push(lengthb2);
									ttarray=[];
									tchglenc=0;
									cutlengthballs.push({
										maxlength:lengthb2,
										chgmaxlength:lengthb2,
										//陣列,材質,號數,最大長度,變動的最大長度,可使用長度
										cutlengthbs:samew03length(t_same,tspec1,tsize1,dec(t_same[j].lengthb),lengthb2,cutlengthb,[])
									});
										
									for (var k=0;k<t_same[j].data.length;k++){
										var ttw03=dec(t_same[j].data[k].tw03);
										lengthb2=dec(t_same[j].lengthb);
										while(ttw03>0){
											lengthb2=lengthb2-1;
											var existscutlens=false;
											for(var l=0;l<maxcutlengthbs.length;l++){
												if(maxcutlengthbs[l]==lengthb2){
													existscutlens=true;
													break;
												}
											}
											if(!existscutlens){
												maxcutlengthbs.push(lengthb2);
												ttarray=[];
												tchglenc=0;
												cutlengthballs.push({
													maxlength:dec(t_same[j].lengthb),
													chgmaxlength:lengthb2,
													//陣列,材質,號數,最大長度,變動的最大長度,可使用長度
													cutlengthbs:samew03length(t_same,tspec1,tsize1,dec(t_same[j].lengthb),lengthb2,cutlengthb,[])
												});
											}
											ttw03--;
										}
									}
									break;
								}
							}						
							//可變動長度e-------------------------------------------------------
							var bcount=0;
							for(var k=0;k<t_cutsheet.length;k++){
								var clength=(dec(t_cutsheet[k])*100); //原單位M
								if(sheetlength.indexOf(t_cutsheet[k])>-1){//要使用板料=設定中可用的裁剪板料
									bcount++;
									
									//106/04/20 調整可裁減長度
									var iswlenzero=false;
									for (var ml=0;ml<maxcutlengthbs.length;ml++){
										for (var mm=0;mm<cutlengthballs.length;mm++){
											if(maxcutlengthbs[ml]==cutlengthballs[mm].chgmaxlength){
												//最短裁剪長度限制
												for(var mx=0;mx<cutlengthballs[mm].cutlengthbs.length;mx++){
													cutlengthb=cutlengthballs[mm].cutlengthbs[mx];
													maxcutlengthb=maxcutlengthbs[ml];
													
													//cutlengthbs=$.extend(true,[], cutlengthb);
													var a_cutlengthbs=[];
													var b_cutlengthbs=[];
													for(var n=0;n<cutlengthb.length;n++){
														if(clength%dec(cutlengthb[n])>0 || t_sortlen>dec(cutlengthb[n])){
															a_cutlengthbs.push(dec(cutlengthb[n]));
														}else{
															b_cutlengthbs.push(dec(cutlengthb[n]));
														}
													}
													
													cutlengthbs=$.extend(true,[], a_cutlengthbs);
													//cutlengthbs=cutlengthbs.concat(b_cutlengthbs);
													//cutlengthbs=cutlengthbs.concat([dec(maxcutlengthb)]);
													rep='';
													
													t_cupsp=false;
													var t_cup=getmlength2(clength,clength,maxcutlengthb,cutlengthbs,'',[],t_same,tspec1,tsize1);
													//---------------------------------------
													//取得所需數量
													var tt_same=[];
													for(var n=0;n<t_same.length;n++){
														var tspec2=t_same[n].spec;
														var tsize2=t_same[n].size;
														var lengthb2=t_same[n].lengthb;
														var tdata2=t_same[n].data;
														if(tspec1==tspec2 && tsize1==tsize2){
															for(var m=0;m<tdata2.length;m++){
																if(dec(tdata2[m].mount)>0){
																	tt_same.push({
																		'maxmount':t_same[n].maxmount,
																		'lengthb':lengthb2,
																		'mount':tdata2[m].mount,
																		'nor':tdata2[m].nor,
																		'tw03':tdata2[m].tw03
																	});
																}
															}
														}
													}
													
													//調整最後剩餘數量是否符合最低損耗率
													for(var f=0;f<t_cup.length;f++){
														var cupcutlength=t_cup[f].cutlength.split('#')[0].split(',');//切割長度
														var cupcutwlength=dec(t_cup[f].cutlength.split('#')[1]);//損耗長度
														var cupolength=t_cup[f].olength;//裁剪的板料長度
														
														var cuttmp=[];//組合數量
														for (var m=0;m<cupcutlength.length;m++){//裁切數量
															var x_n=-1;
															for (var n=0;n<cuttmp.length;n++){
																if(cuttmp[n].lengthb==dec(cupcutlength[m])){
																	cuttmp[n].mount=cuttmp[n].mount+1;
																	x_n=n;
																	break;	
																}
															}
															if(x_n==-1){
																cuttmp.push({
																	'lengthb':dec(cupcutlength[m]),
																	'mount':1
																});
															}
														}
														var t_wlength=dec(cupolength);
														/*if(t_wlength.toString().slice(-1)=='5'){
															t_wlength=dec(t_wlength.toString().substr(0,t_wlength.toString().length-1)+'0');
														}*/
														
														var t_cutlength='';
														for (var m=0;m<cuttmp.length;m++){
															for (var n=0;n<tt_same.length;n++){
																if(dec(cuttmp[m].mount)>0 && dec(cuttmp[m].lengthb)<=dec(tt_same[n].lengthb) && dec(cuttmp[m].lengthb)>=(dec(tt_same[n].lengthb)-dec(tt_same[n].tw03))){
																	if(dec(cuttmp[m].mount)>dec(tt_same[n].mount)+dec(tt_same[n].maxmount)){
																		t_wlength=q_sub(t_wlength,q_mul(dec(cuttmp[m].lengthb),dec(tt_same[n].mount)+dec(tt_same[n].maxmount)));
																		var ttt_mount=dec(tt_same[n].mount)+dec(tt_same[n].maxmount);
																		while(ttt_mount>0){
																			t_cutlength=t_cutlength+(t_cutlength.length>0?',':'')+cuttmp[m].lengthb;
																			ttt_mount--;
																			cuttmp[m].mount=dec(cuttmp[m].mount)-1;
																		}
																	}else{
																		t_wlength=q_sub(t_wlength,q_mul(dec(cuttmp[m].lengthb),cuttmp[m].mount));
																		var ttt_mount=cuttmp[m].mount;
																		while(ttt_mount>0){
																			t_cutlength=t_cutlength+(t_cutlength.length>0?',':'')+cuttmp[m].lengthb;
																			ttt_mount--;
																			cuttmp[m].mount=dec(cuttmp[m].mount)-1;
																		}
																	}
																	//106/09/14 不受項次限制
																	//break;
																}
															}
														}
														if(t_wlength<0)
															t_wlength=0;
														t_cup[f].wlenhth=t_wlength;
														t_cup[f].wrate=t_wlength/dec(cupolength);
														t_cup[f].cutlength=t_cutlength+'#'+t_wlength;
														if(t_cup[f].wrate>0){
															t_cup.splice(f,1)
															f--;
														}
													}
													
													//--------------------------------------
													if(t_cup.length==0){
														rep='';
														if(b_cutlengthbs.indexOf(maxcutlengthb)>-1){
															cutlengthbs=cutlengthbs=$.extend(true,[], b_cutlengthbs);
														}
														
														t_cup=getmlength(clength,clength,maxcutlengthb,cutlengthbs,'',[],[],tspec1,tsize1,t_stlen);
													}
													if(t_cup.length==0){
														var a_cutlengthbs=[];
														var b_cutlengthbs=[];
														for(var n=0;n<cutlengthb.length;n++){
															if(clength%dec(cutlengthb[n])>0 || t_sortlen>dec(cutlengthb[n])){
																a_cutlengthbs.push(dec(cutlengthb[n]));
															}else{
																b_cutlengthbs.push(dec(cutlengthb[n]));
															}
														}
														
														cutlengthbs=$.extend(true,[], a_cutlengthbs);
														cutlengthbs=cutlengthbs.concat(b_cutlengthbs);
														cutlengthbs=cutlengthbs.concat([dec(maxcutlengthb)]);
														rep='';
														t_cup=getmlength(clength,clength,maxcutlengthb,cutlengthbs,'',[],t_same,tspec1,tsize1,t_stlen);
													}else{
														t_cupsp=true;
													}
													t_cup.sort(function(a, b) { if(a.wrate > b.wrate) {return 1;} if (a.wrate < b.wrate) {return -1;}if(a.cutlength.split(',').length>b.cutlength.split(',').length) {return 1;}if(a.cutlength.split(',').length<b.cutlength.split(',').length) {return -1;}return 0;});
													t_cups=t_cups.concat(t_cup);
													
													//106/05/10 取到最無損號就不計算可誤差
													if(t_cup.length>0){
														if(t_cup[0].wlenhth==0){
															iswlenzero=true;
															break;
														}													
													}
												}
											}
											if(iswlenzero){break;}
										}
										if(iswlenzero){break;}
									}
								}
								
								t_cups.sort(function(a, b) {
									if(a.wrate > b.wrate) {return 1;} 
									if(a.wrate < b.wrate) {return -1;}
									return 0;
								});
								
								//107/02/01 若原長度已有最好組合衍伸長度就不做組合
								var t_levc=true;
								if(t_cups.length>0){
									if(t_cups[0].wrate==0){
										t_levc=false;
									}
								}
								
								if(dec($('#txtLevel').val())>0 && t_levc){
									var t_level=dec($('#txtLevel').val());
									if (t_level>0){
										clength=(dec(t_cutsheet[k])*100)+t_level; //原單位M
										if(sheetlength.indexOf(t_cutsheet[k])>-1){//要使用板料=設定中可用的裁剪板料
											bcount++;
											
											//106/04/20 調整可裁減長度
											var iswlenzero=false;
											for (var ml=0;ml<maxcutlengthbs.length;ml++){
												for (var mm=0;mm<cutlengthballs.length;mm++){
													if(maxcutlengthbs[ml]==cutlengthballs[mm].chgmaxlength){
														//最短裁剪長度限制
														for(var mx=0;mx<cutlengthballs[mm].cutlengthbs.length;mx++){
															cutlengthb=cutlengthballs[mm].cutlengthbs[mx];
															maxcutlengthb=maxcutlengthbs[ml];
											
															//cutlengthbs=$.extend(true,[], cutlengthb);
															
															var a_cutlengthbs=[];
															var b_cutlengthbs=[];
															for(var n=0;n<cutlengthb.length;n++){
																if(clength%dec(cutlengthb[n])>0 || t_sortlen>dec(cutlengthb[n])){
																	a_cutlengthbs.push(dec(cutlengthb[n]));
																}else{
																	b_cutlengthbs.push(dec(cutlengthb[n]));
																}
															}
															
															cutlengthbs=$.extend(true,[], a_cutlengthbs);
															//cutlengthbs=cutlengthbs.concat(b_cutlengthbs);
															//cutlengthbs=cutlengthbs.concat([dec(maxcutlengthb)]);
															
															rep='';
															var t_cup=getmlength2(clength,clength,maxcutlengthb,cutlengthbs,'',[],t_same,tspec1,tsize1);
															//---------------------------------------
															//取得所需數量
															var tt_same=[];
															for(var n=0;n<t_same.length;n++){
																var tspec2=t_same[n].spec;
																var tsize2=t_same[n].size;
																var lengthb2=t_same[n].lengthb;
																var tdata2=t_same[n].data;
																if(tspec1==tspec2 && tsize1==tsize2){
																	for(var m=0;m<tdata2.length;m++){
																		if(dec(tdata2[m].mount)>0){
																			tt_same.push({
																				'maxmount':t_same[n].maxmount,
																				'lengthb':lengthb2,
																				'mount':tdata2[m].mount,
																				'nor':tdata2[m].nor,
																				'tw03':tdata2[m].tw03
																			});
																		}
																	}
																}
															}
															
															//調整最後剩餘數量是否符合最低損耗率
															for(var f=0;f<t_cup.length;f++){
																var cupcutlength=t_cup[f].cutlength.split('#')[0].split(',');//切割長度
																var cupcutwlength=dec(t_cup[f].cutlength.split('#')[1]);//損耗長度
																var cupolength=t_cup[f].olength;//裁剪的板料長度
																
																var cuttmp=[];//組合數量
																for (var m=0;m<cupcutlength.length;m++){//裁切數量
																	var x_n=-1;
																	for (var n=0;n<cuttmp.length;n++){
																		if(cuttmp[n].lengthb==dec(cupcutlength[m])){
																			cuttmp[n].mount=cuttmp[n].mount+1;
																			x_n=n;
																			break;	
																		}
																	}
																	if(x_n==-1){
																		cuttmp.push({
																			'lengthb':dec(cupcutlength[m]),
																			'mount':1
																		});
																	}
																}
																var t_wlength=dec(cupolength);
																/*if(t_wlength.toString().slice(-1)=='5'){
																	t_wlength=dec(t_wlength.toString().substr(0,t_wlength.toString().length-1)+'0');
																}*/
																
																var t_cutlength='';
																for (var m=0;m<cuttmp.length;m++){
																	for (var n=0;n<tt_same.length;n++){
																		if(dec(cuttmp[m].mount)>0 && dec(cuttmp[m].lengthb)<=dec(tt_same[n].lengthb) && dec(cuttmp[m].lengthb)>=(dec(tt_same[n].lengthb)-dec(tt_same[n].tw03))){
																			if(dec(cuttmp[m].mount)>dec(tt_same[n].mount)+dec(tt_same[n].maxmount)){
																				t_wlength=q_sub(t_wlength,q_mul(dec(cuttmp[m].lengthb),dec(tt_same[n].mount)+dec(tt_same[n].maxmount)));
																				var ttt_mount=dec(tt_same[n].mount)+dec(tt_same[n].maxmount);
																				while(ttt_mount>0){
																					t_cutlength=t_cutlength+(t_cutlength.length>0?',':'')+cuttmp[m].lengthb;
																					ttt_mount--;
																					cuttmp[m].mount=dec(cuttmp[m].mount)-1;
																				}
																			}else{
																				t_wlength=q_sub(t_wlength,q_mul(dec(cuttmp[m].lengthb),cuttmp[m].mount));
																				var ttt_mount=cuttmp[m].mount;
																				while(ttt_mount>0){
																					t_cutlength=t_cutlength+(t_cutlength.length>0?',':'')+cuttmp[m].lengthb;
																					ttt_mount--;
																					cuttmp[m].mount=dec(cuttmp[m].mount)-1;
																				}
																			}
																			//106/09/14 不受項次限制
																			//break;
																		}
																	}
																}
																if(t_wlength<0)
																	t_wlength=0;
																t_cup[f].wlenhth=t_wlength;
																t_cup[f].wrate=t_wlength/dec(cupolength);
																t_cup[f].cutlength=t_cutlength+'#'+t_wlength;
																if(t_cup[f].wrate>0){
																	t_cup.splice(f,1)
																	f--;
																}
															}
															
															//--------------------------------------
															if(t_cup.length==0 && !t_cupsp){
																rep='';
																if(b_cutlengthbs.indexOf(maxcutlengthb)>-1){
																	cutlengthbs=cutlengthbs=$.extend(true,[], b_cutlengthbs);
																}
																t_cup=getmlength(clength,clength,maxcutlengthb,cutlengthbs,'',[],[],tspec1,tsize1,t_stlen);
															}
															if(t_cup.length==0 && !t_cupsp){
																var a_cutlengthbs=[];
																var b_cutlengthbs=[];
																for(var n=0;n<cutlengthb.length;n++){
																	if(clength%dec(cutlengthb[n])>0 || t_sortlen>dec(cutlengthb[n])){
																		a_cutlengthbs.push(dec(cutlengthb[n]));
																	}else{
																		b_cutlengthbs.push(dec(cutlengthb[n]));
																	}
																}
																
																cutlengthbs=$.extend(true,[], a_cutlengthbs);
																cutlengthbs=cutlengthbs.concat(b_cutlengthbs);
																cutlengthbs=cutlengthbs.concat([dec(maxcutlengthb)]);
																
																rep='';
																var t_cup=getmlength(clength,clength,maxcutlengthb,cutlengthbs,'',[],t_same,tspec1,tsize1,t_stlen);
															}
															t_cup.sort(function(a, b) { if(a.wrate > b.wrate) {return 1;} if (a.wrate < b.wrate) {return -1;}if(a.cutlength.split(',').length>b.cutlength.split(',').length) {return 1;}if(a.cutlength.split(',').length<b.cutlength.split(',').length) {return -1;}return 0;});
															t_cups=t_cups.concat(t_cup);
															
															//106/05/10 取到最無損號就不計算可誤差
															if(t_cup.length>0){
																if(t_cup[0].wlenhth==0){
																	iswlenzero=true;
																	break;
																}													
															}
														}
													}
													if(iswlenzero){break;}
												}
												if(iswlenzero){break;}
											}
										}
									}
								}
							}
							if(bcount==0){
								alert(tspec1+' '+tsize1+'無可使用的板料長度!!');
								break;
							}
							
							//處理最短裁剪長度限制
							if(t_sortlen>0){
								for(var k=0;k<t_cups.length;k++){
									var cupolength=t_cups[k].olength;//裁剪的板料長度
									var cupcutlength=t_cups[k].cutlength.split('#')[0].split(',');//切割長度
									var cupcutlength2=t_cups[k].cutlength.split('#')[0].split(',');//切割長度(無損耗長度)
									var cupcutwlength=dec(t_cups[k].cutlength.split('#')[1]);//損耗長度
									cupcutlength=cupcutlength.concat(cupcutwlength);//加損耗
									var changecup=true;
									for (var m=0;m<cupcutlength.length;m++){
										if(dec(cupcutlength[m])>=t_sortlen){
											changecup=false;
											break;
										}
									}
									if(changecup){ //剪裁長度低於最短裁剪長度
										//拿最小損耗長度當尾刀 加價損失(最小長度限制,已損耗長度,可配對長度,已裁剪長度,暫存裁剪陣列)
										var t_sortcup=getsortlen(dec(t_sortlen),dec(cupcutwlength),cupcutlength2,cupcutwlength,[]);
										t_sortcup.sort(function(a, b) { if(a.wrate > b.wrate) {return 1;} if (a.wrate < b.wrate) {return -1;} return 0;});
										
										if(t_sortcup.length>0){
											var tt_cutlength='';
											var tt_scutlength=t_sortcup[0].cutlength.split(',');
											
											if(dec(cupcutwlength)>0){//原裁剪已有損耗 排除第一筆長度
												tt_scutlength.splice(0, 1);
											}
											//將原裁剪內容變動
											for (var m=0;m<cupcutlength2.length;m++){
												for (var n=0;n<tt_scutlength.length;n++){
													if(cupcutlength2[m]==tt_scutlength[n]){
														cupcutlength2.splice(m, 1);
														m--;
														tt_scutlength.splice(n, 1);
														n--;
													}
												}
											}
											for (var m=0;m<cupcutlength2.length;m++){
												tt_cutlength=tt_cutlength+(tt_cutlength.length>0?',':'')+cupcutlength2[m];
											}
											tt_cutlength=tt_cutlength+'#'+t_sortcup[0].wlength;
											t_cups[k].cutlength=tt_cutlength;
											t_cups[k].wlenhth=t_sortcup[0].wlength;
											t_cups[k].wrate=t_sortcup[0].wlength/t_cups[k].olength;
										}
									}
								}
							}
							
							//取得所需數量
							var tt_same=[];
							for(var k=0;k<t_same.length;k++){
								var tspec2=t_same[k].spec;
								var tsize2=t_same[k].size;
								var lengthb2=t_same[k].lengthb;
								var tdata2=t_same[k].data;
								if(tspec1==tspec2 && tsize1==tsize2){
									for(var l=0;l<tdata2.length;l++){
										if(dec(tdata2[l].mount)>0){
											tt_same.push({
												'maxmount':t_same[k].maxmount,
												'lengthb':lengthb2,
												'mount':tdata2[l].mount,
												'nor':tdata2[l].nor,
												'tw03':tdata2[l].tw03
											});
										}
									}
								}
							}
							
							//調整最後剩餘數量是否符合最低損耗率
							for(var k=0;k<t_cups.length;k++){
								var cupcutlength=t_cups[k].cutlength.split('#')[0].split(',');//切割長度
								var cupcutwlength=dec(t_cups[k].cutlength.split('#')[1]);//損耗長度
								var cupolength=t_cups[k].olength;//裁剪的板料長度
								
								var cuttmp=[];//組合數量
								for (var m=0;m<cupcutlength.length;m++){//裁切數量
									var x_n=-1;
									for (var n=0;n<cuttmp.length;n++){
										if(cuttmp[n].lengthb==dec(cupcutlength[m])){
											cuttmp[n].mount=cuttmp[n].mount+1;
											x_n=n;
											break;	
										}
									}
									if(x_n==-1){
										cuttmp.push({
											'lengthb':dec(cupcutlength[m]),
											'mount':1
										});
									}
								}
								var t_wlength=dec(cupolength);
								/*if(t_wlength.toString().slice(-1)=='5'){
									t_wlength=dec(t_wlength.toString().substr(0,t_wlength.toString().length-1)+'0');
								}*/
								
								var t_cutlength='';
								for (var m=0;m<cuttmp.length;m++){
									for (var n=0;n<tt_same.length;n++){
										if(dec(cuttmp[m].mount)>0 && dec(cuttmp[m].lengthb)<=dec(tt_same[n].lengthb) && dec(cuttmp[m].lengthb)>=(dec(tt_same[n].lengthb)-dec(tt_same[n].tw03))){
											if(dec(cuttmp[m].mount)>dec(tt_same[n].mount)+dec(tt_same[n].maxmount)){
												t_wlength=q_sub(t_wlength,q_mul(dec(cuttmp[m].lengthb),dec(tt_same[n].mount)+dec(tt_same[n].maxmount)));
												var ttt_mount=dec(tt_same[n].mount)+dec(tt_same[n].maxmount);
												while(ttt_mount>0){
													t_cutlength=t_cutlength+(t_cutlength.length>0?',':'')+cuttmp[m].lengthb;
													ttt_mount--;
													cuttmp[m].mount=dec(cuttmp[m].mount)-1;
												}
											}else{
												t_wlength=q_sub(t_wlength,q_mul(dec(cuttmp[m].lengthb),cuttmp[m].mount));
												var ttt_mount=cuttmp[m].mount;
												while(ttt_mount>0){
													t_cutlength=t_cutlength+(t_cutlength.length>0?',':'')+cuttmp[m].lengthb;
													ttt_mount--;
													cuttmp[m].mount=dec(cuttmp[m].mount)-1;
												}
											}
											//106/09/14 不受項次限制
											//break;
										}
									}
								}
								if(t_wlength<0)
									t_wlength=0;
								t_cups[k].wlenhth=t_wlength;
								t_cups[k].wrate=t_wlength/dec(cupolength);
								t_cups[k].cutlength=t_cutlength+'#'+t_wlength;
							}
							
							//損耗率排序 低損耗>長板料>裁剪長度>裁剪次數
							//t_cups.sort(function(a, b) { if(a.wrate > b.wrate) {return 1;} if (a.wrate < b.wrate) {return -1;} if(a.olength > b.olength) {return -1;} if (a.olength < b.olength) {return 1;} return 0;});
							
							if(tsize1=='3#' || tsize1=='4#' || tsize1=='5#'){
								//刪除小於最小定尺的損耗組合
								for(var k=0;k<t_cups.length;k++){
									var ttlengthb=dec(t_cups[k].olength.toString().substr(0,t_cups[k].olength.toString().length-2)+'00');
									var t_wlen=t_cups[k].wlenhth;
									if(ttlengthb!=t_cups[k].olength && t_wlen<=(t_cups[k].olength-ttlengthb)){
										t_wlen=0;
									}
									
									if(t_wlen>0 && t_wlen<t_stlen){
										t_cups.splice(k, 1);
                                    	k--;
									}
								}
							}
							
							t_cups.sort(function(a, b) { 
								if(a.wrate > b.wrate) {return 1;} 
								if(a.wrate < b.wrate) {return -1;}
								/*if(lengthmount(a.cutlength,t_same,maxcutlengthbs)>lengthmount(b.cutlength,t_same,maxcutlengthbs)){return -1;}
								if(lengthmount(a.cutlength,t_same,maxcutlengthbs)<lengthmount(b.cutlength,t_same,maxcutlengthbs)){return 1;}*/
								if(dec(a.olength.toString().substr(0,a.olength.toString().length-2)+'00') > dec(b.olength.toString().substr(0,b.olength.toString().length-2)+'00')) {return -1;}
								if(dec(a.olength.toString().substr(0,a.olength.toString().length-2)+'00') < dec(b.olength.toString().substr(0,b.olength.toString().length-2)+'00')) {return 1;}
								if(a.cutlength.split(',').length>b.cutlength.split(',').length) {return 1;}
								if(a.cutlength.split(',').length<b.cutlength.split(',').length) {return -1;}
								if(a.olength > b.olength) {return 1;} 
								if(a.olength < b.olength) {return -1;}
								if(lengthgroup(a.cutlength)>lengthgroup(b.cutlength)){return 1;}
								if(lengthgroup(a.cutlength)<lengthgroup(b.cutlength)){return -1;} 
								return 0;
							});
							
							var tt_zero=false;
							if(tt_same.length>0){//數量大於0才做 越小的長度有可能在之前的裁剪已裁剪出來
								var cuttmp=[];//組合數量
								//找出目前最大長度數量的組合與最小損耗
								var cupcutlength=t_cups[0].cutlength.split('#')[0].split(',');//切割長度
								var cupcutwlength=dec(t_cups[0].cutlength.split('#')[1]);//損耗長度
								var cupolength=t_cups[0].olength;//裁剪的板料長度
								
								var bmount=0;//板料使用數量
								//cupcutlength=cupcutlength.concat(cupcutwlength);//加損耗
								var usemax=0; //使用容許多入數量M09
								while(!tt_zero){ //當最大長度需裁剪量數量<0 或 其他剪裁長度需才剪量<0
									bmount++;
									for (var m=0;m<cupcutlength.length;m++){//裁切數量
										var x_n=-1;
										for (var n=0;n<cuttmp.length;n++){
											if(cuttmp[n].lengthb==dec(cupcutlength[m])){
												cuttmp[n].mount=cuttmp[n].mount+1;
												x_n=n;
												break;	
											}
										}
										if(x_n==-1){
											cuttmp.push({
												'lengthb':dec(cupcutlength[m]),
												'mount':1
											});
										}
										for (var n=0;n<tt_same.length;n++){
											if(dec(cupcutlength[m])<=dec(tt_same[n].lengthb) && dec(cupcutlength[m])>=(dec(tt_same[n].lengthb)-dec(tt_same[n].tw03))
												&& dec(tt_same[n].mount)+dec(tt_same[n].maxmount)>0
											){
												if(dec(tt_same[n].mount)>0)
													tt_same[n].mount=q_sub(tt_same[n].mount,1);
												else
													tt_same[n].maxmount=q_sub(tt_same[n].maxmount,1);
													
												//判斷是否還有其他相同長度
												if(dec(tt_same[n].mount)+dec(tt_same[n].maxmount)<=0){
													var x_nn=-1
													for (var x=0;x<tt_same.length;x++){
														if(dec(cupcutlength[m])<=dec(tt_same[x].lengthb) && dec(cupcutlength[m])>=(dec(tt_same[x].lengthb)-dec(tt_same[x].tw03))
															&& dec(tt_same[x].mount)>0
														){
															x_nn=x;
														}
													}
													if(x_nn==-1){
														tt_zero=true;
													}
												}
												
												//107/02/06 依據台料 判斷是否受項次限制
												/*if(!$('#chkCancel').prop('checked')){
													if(dec(tt_same[n].mount)+dec(tt_same[n].maxmount)<=0){
														tt_zero=true;
													}
													if(dec(tt_same[n].mount)<=0 && dec(tt_same[n].maxmount)>0){
														usemax++;
													}
												}*/
												
												break;
											}
										}
									}
									
									if(usemax>0){
										tt_zero=true;
									}
									
									//檢查下次裁剪是否會多裁剪的數量
									var t_nn=-1;
									if(!tt_zero){
										var ttt_same=$.extend(true,[], tt_same);
										for (var m=0;m<cupcutlength.length;m++){//裁切數量
											var isexist=false;//判斷是否還有被扣料
											for (var n=0;n<ttt_same.length;n++){
												if(dec(cupcutlength[m])<=dec(ttt_same[n].lengthb) && dec(cupcutlength[m])>=(dec(ttt_same[n].lengthb)-dec(ttt_same[n].tw03))
													&& dec(ttt_same[n].mount)+dec(ttt_same[n].maxmount)>0
												){
													if(dec(ttt_same[n].mount)>0){
														ttt_same[n].mount=q_sub(ttt_same[n].mount,1);
														t_nn=n;	
													}else
														ttt_same[n].maxmount=q_sub(ttt_same[n].maxmount,1);
													
													isexist=true;
													
													/*if(dec(ttt_same[n].mount)+dec(ttt_same[n].maxmount)<0){
														tt_zero=true;
													}*/
													break;
												}
											}
											if(!isexist)
												tt_zero=true;
										}
									}
									//判斷是否下次是否可被裁減
									if(t_nn==-1){
										tt_zero=true;
									}
								}
								cupcutlength=cupcutlength.concat(cupcutwlength);//加損耗
								getucc.push({
									'spec':tspec1,
									'size':tsize1,
									'lengthb':cupolength,
									'wlengthb':cupcutwlength,
									'mount':bmount,
									'usemaxmount':usemax,
									'nor':'',
									'cutlen':cupcutlength,
									'data':cuttmp,
									'typea':'b'
								});
							}
							
							var t_nor='';
							var t_noras=[];
							//扣除已裁切完的數量
							cuttmp.sort(function(a, b) { if(dec(a.lengthb) > dec(b.lengthb)) {return 1;} if (dec(a.lengthb) < dec(b.lengthb)) {return -1;} return 0;})
							for (var m=0;m<cuttmp.length;m++){
								for(var k=0;k<t_same.length;k++){
									var tspec2=t_same[k].spec;
									var tsize2=t_same[k].size;
									var lengthb2=t_same[k].lengthb;
									var tdata2=t_same[k].data;
									var texists2=false;
									for (var x=0;x<tdata2.length;x++){
										if(tspec1==tspec2 && tsize1==tsize2 && dec(tdata2[x].mount)>0 && dec(cuttmp[m].mount)>0 
											&& dec(cuttmp[m].lengthb)<=dec(lengthb2) && dec(cuttmp[m].lengthb)>=(dec(lengthb2)-dec(tdata2[x].tw03))
										){
											var tcutmount=0;
											if(t_same[k].data[x].mount>=cuttmp[m].mount){
												tcutmount=cuttmp[m].mount;
												t_same[k].mount=t_same[k].mount-cuttmp[m].mount;
												t_same[k].data[x].mount=t_same[k].data[x].mount-cuttmp[m].mount;
												cuttmp[m].mount=0;
											}else{
												tcutmount=t_same[k].data[x].mount;
												t_same[k].mount=t_same[k].mount-t_same[k].data[x].mount;
												cuttmp[m].mount=cuttmp[m].mount-t_same[k].data[x].mount;
												t_same[k].data[x].mount=0;
											}
											
											if(t_same[k].data[x].mount<0 && t_same[k].maxmount>0){
												t_same[k].maxmount=t_same[k].maxmount+t_same[k].data[x].mount;
											}
											if(t_same[k].maxmount<0){
												t_same[k].maxmount=0;
											}
											
											var tt_nor=t_nor.split(',');
											var tt_norexist=false;
											for(var o=0;o<tt_nor.length;o++){
												if(tt_nor[o]==(t_same[k].data[x].nor+1).toString()){
													tt_norexist=true;
													break;
												}
											}
											if(!tt_norexist){
												t_nor=t_nor+(t_nor.length>0?',':'')+(t_same[k].data[x].nor+1);
											}
											//106/09/14-------------------------------
											tt_norexist=false;
											for(var o=0;o<t_noras.length;o++){
												if(t_noras[o].nor==(t_same[k].data[x].nor+1).toString()){
													t_noras[o].mount=q_add(t_noras[o].mount,tcutmount);
													tt_norexist=true;
													break;
												}
											}
											if(!tt_norexist){
												t_noras.push({
													nor:(t_same[k].data[x].nor+1).toString(),
													mount:tcutmount
												});
											}
											//-----------------------------
											//106/09/14 不受項次限制
											//texists2=true;
											//break;
											if(cuttmp[m].mount<=0){
												texists2=true;
												break;
											}
										}
									}
									if(texists2){
										break;
									}
								}
							}
							//更新最後一個物料的配料項次
							if(getucc.length>0){
								if(getucc[getucc.length-1].nor=='')
									getucc[getucc.length-1].nor=t_nor;
								getucc[getucc.length-1].noras=t_noras;
							}
							
							//已裁剪完的長度已不需要
							//cutlengthb.splice(j, 1);
							//j--;
							//其他剪長的長度也刪除
							for(var m=0;m<cutlengthb.length;m++){
								for(var k=0;k<t_same.length;k++){
									var tspec2=t_same[k].spec;
									var tsize2=t_same[k].size;
									var lengthb2=t_same[k].lengthb;
									var mount2=t_same[k].mount;
									if(tspec1==tspec2 && tsize1==tsize2 && cutlengthb[m]==lengthb2 && mount2<=0){
										cutlengthb.splice(m, 1);
										m--;
									}
								}	
							}
						
							//重新排序--------------------------------------------------
							//讀取相同材質號數的長度
							cutlengthb=[];
							cutlengthballs=[];
							maxcutlengthb='0';
							maxcutlengthbs=[];
							
							var t_cutlengthb=[];
							for (var j=0;j<t_same.length;j++){
								var tspec2=t_same[j].spec;
								var tsize2=t_same[j].size;
								var tmount2=t_same[j].mount;
								var lengthb2=dec(t_same[j].lengthb);
								if(tspec1==tspec2 && tsize1==tsize2 && dec(tmount2)>0){
									t_cutlengthb.push({
										'lengthb':lengthb2,
										'mount':tmount2
									});
								}
							}
							t_cutlengthb.sort(function(a, b) {if(a.mount>b.mount) {return 1;} if (a.mount < b.mount) {return -1;} if(a.lengthb>b.lengthb) {return 1;} if (a.lengthb < b.lengthb) {return -1;} return 0;});
							for (var j=0;j<t_cutlengthb.length;j++){
								cutlengthb.push(t_cutlengthb[j].lengthb);
							}
							maxcutlengthb=cutlengthb[0];
						}
					}
				}
				
				t_p4getucc=$.extend(true,[], getucc);
				return;

			}
			
			//106/11/23
			function getp3 (){
				var t_err='';
				//---------------------------------------------------------------
				var t_sortlen=0;//最短裁剪限制長度
				q_gt('mech', "where=^^noa='"+$('#cmbMechno').val()+"'^^" , 0, 0, 0, "getmech",r_accy,1); //號數
				var as = _q_appendData("mech", "", true);
				if (as[0] != undefined) {
					t_sortlen=as[0].dime1;
				}
				
				var t_cutsheet=$('#combStatus').val();//可裁剪的板料長度
				var maxcutsheet=0;//最大板料長度
				if($('#combStatus').find("option:selected").text().length==0){
					t_cutsheet='12';
					t_cutsheet=t_cutsheet.split(',');
				}
				for (var i = 0; i < t_cutsheet.length; i++) {
					if(maxcutsheet<dec(t_cutsheet[i])*100){
						maxcutsheet=dec(t_cutsheet[i])*100;
					}
				}
				
				//106/03/23 已最大版料先下去配料
				t_cutsheet.sort(function(a, b) {if(a>b) {return -1;} if (a < b) {return 1;} return 0;})
				//---------------------------------------------------------------
				
				//相同材質號數長度合併
				//105/08/25 基礎螺栓 不用餘料裁剪 一起帶入組合裁剪 SD420W
				//105/08/25 安全存量 連同帶入表身資料
				var t_same=[]; //bbs可裁剪的內容(相同材質號數長度)
				for (var i = 0; i < q_bbsCount; i++) {
					if(!emp($('#txtProductno_'+i).val()) && !emp($('#txtProduct_'+i).val()) 
					&& ($('#txtProduct_'+i).val().indexOf('鋼筋')>-1 || $('#txtProduct_'+i).val().indexOf('螺栓')>-1)
					&& dec($('#txtLengthb_'+i).val())<=maxcutsheet){
						var tproduct=$('#txtProduct_'+i).val();
						var tmount=dec($('#txtMount_'+i).val());//裁剪數量
						//材質號數長度
						var tspec='';
						var tsize='';
						if(tproduct.indexOf('螺栓')>-1){
							tspec='SD420W';
							tsize=replaceAll(replaceAll(tproduct.split('#')[0]+'#','基礎螺栓',''),'抗震專利','');
						}else{ //鋼筋
							tspec=tproduct.substr(tproduct.indexOf('S'),tproduct.indexOf(' ')-tproduct.indexOf('S'));
							tsize=tproduct.split(' ')[1].split('*')[0];
						}
						var tlength=dec($('#txtLengthb_'+i).val());
						var twaste=dec($('#txtWaste').val()); //容許損耗長度
						var to=dec($('#txtMo').val()); //容許損耗%
						var tw03=dec($('#txtW03_'+i).val());// 圖形可誤差長度
							
						var t_j=-1;
						for (var j=0;j<t_same.length;j++){
							if(t_same[j].spec==tspec && t_same[j].size==tsize && t_same[j].lengthb==tlength){
								t_j=j;
								t_same[j].data.push({
									'nor':i,
									'mount':tmount,
									'tw03':tw03
								})
								t_same[j].mount=t_same[j].mount+tmount;
								break;
							}
						}
						
						if(t_j<0){
							t_same.push({
								'spec':tspec,
								'size':tsize,
								'lengthb':tlength,
								'mount':tmount,
								'data':[{
									'nor':i,
									'mount':tmount,
									'tw03':tw03
								}]
							});
						}
					}
				}
				
				var t_m9=dec($('#txtM9').val());
				if(t_m9<=0 || t_m9==undefined)
					t_m9=0;
				for (var i=0;i<t_same.length;i++){
					t_same[i].maxmount=round(t_same[i].mount*(t_m9/100),0);
				}
				
				//107/01/26加入可補足安全存量(非領用) //107/02/06 取消增量模式
				for (var i=0;i<safeas.length;i++){
					for (var j=0;j<t_same.length;j++){
						if(safeas[i].spec==t_same[j].spec && safeas[i].size==t_same[j].size && safeas[i].lengthb==t_same[j].lengthb){
							var t_mount=dec(safeas[i].addsafe);//-dec(safeas[i].mount);
							t_same[j].maxmount=q_add(dec(t_same[j].maxmount),t_mount);
						}
					}
				}
				
				var getucc=[];
				
				//107/01/31 排除可直接使用安全庫存
				for (var j=0;j<t_same.length;j++){
					for (var i=0;i<safehas.length;i++){
						if(safehas[i].spec==t_same[j].spec && safehas[i].size==t_same[j].size && safehas[i].lengthb==t_same[j].lengthb){
							if(t_same[j].mount<=safehas[i].smount){ //全部使用安全存量
								var t_nor='',t_noras=[];
								for (var k=0;k<t_same[j].data.length;k++){
									t_nor+=(t_nor.length>0?",":'')+(t_same[j].data[k].nor+1).toString();
									t_noras.push({
										'nor':t_same[j].data[k].nor+1,
										'mount':t_same[j].mount
									});
								}
								getucc.push({
									'spec':t_same[j].spec,
									'size':t_same[j].size,
									'lengthb':t_same[j].lengthb,
									'wlengthb':0,
									'mount':t_same[j].mount,
									'usemaxmount':t_same[j].maxmount,
									'nor':t_nor,
									'noras':t_noras,
									'cutlen':[t_same[j].lengthb],
									'data':[{'lengthb':t_same[j].lengthb,'mount':t_same[j].mount}],
									'typea':'s'
								});
								t_same.splice(j, 1);
								j--;
							}else{//部分
								var t_nor='',t_noras=[],t_smount=safehas[i].smount;
								for (var k=0;k<t_same[j].data.length;k++){
									if(t_smount>0 && t_same[j].data[k].mount>0){
										t_nor+=(t_nor.length>0?",":'')+(t_same[j].data[k].nor+1).toString();
										if(t_smount>=t_same[j].data[k].mount){
											t_noras.push({
												'nor':t_same[j].data[k].nor+1,
												'mount':t_same[j].data[k].mount
											});
											
											t_smount=t_smount-t_same[j].data[k].mount;
											t_same[j].mount=t_same[j].mount-t_same[j].data[k].mount
											t_same[j].data[k].mount=0;
											t_same[j].data.splice(k, 1);
											k--;
										}else{
											t_noras.push({
												'nor':t_same[j].data[k].nor+1,
												'mount':t_smount
											});
											
											t_same[j].data[k].mount=t_same[j].data[k].mount-t_smount;
											t_same[j].mount=t_same[j].mount-t_smount;
											t_smount=0;
										}
									}
								}
								
								getucc.push({
									'spec':t_same[j].spec,
									'size':t_same[j].size,
									'lengthb':t_same[j].lengthb,
									'wlengthb':0,
									'mount':safehas[i].smount,
									'usemaxmount':t_same[j].maxmount,
									'nor':t_nor,
									'noras':t_noras,
									'cutlen':[t_same[j].lengthb],
									'data':[{'lengthb':t_same[j].lengthb,'mount':safehas[i].smount}],
									'typea':'s'
								});
							}
							break;
						}
					}
				}
									
				//推算選料
				//先裁剪最大長度
				t_same.sort(function(a, b) {if(a.lengthb>b.lengthb) {return -1;} if (a.lengthb < b.lengthb) {return 1;} return 0;});
				
				var specsize='';//存放已做的材質和號數
				var as_add5=[];//暫存可使用板料長度
				var t_stlen=50; //取最小定尺尺寸
				for (var i=0;i<t_same.length;i++){
					var sheetlength=''; //板料可用長度
					//材質號數
					var tspec1=t_same[i].spec;
					var tsize1=t_same[i].size;
					//取得設定可使用的板料長度
					var add5n=-1;
					for(var x5n=0;x5n<as_add5.length;x5n++){
						if(as_add5[x5n].size==tsize1){
							add5n=x5n;
							break;
						}
					}
					
					if(as_add5.length>0 && add5n!=-1){
						sheetlength=as_add5[0].sheetlength;
					}else{
						q_gt('add5', "where=^^typea='"+tsize1+"'^^" , 0, 0, 0, "getadd5",r_accy,1); //號數
						var as = _q_appendData("add5s", "", true);
						for (var j=0;j<as.length;j++){
							sheetlength=sheetlength+as[j].postno+',';
						}
						
						as_add5.push({
							'size':tsize1,
							'sheetlength':sheetlength
						});
					}
					
					if(tsize1=='3#' || tsize1=='4#' || tsize1=='5#'){
						//取最小定尺尺寸
						if(t_same[0]!= undefined){
							q_gt('adknife', "where=^^ style='"+t_same[0].size+"'^^", 0, 0, 0, "getadknife",r_accy,1);
							var as = _q_appendData("adknife", "", true);
							if(as[0]!= undefined){
								if(as[0].memo.length>0){
									t_stlen=dec(replaceAll(as[0].memo.split('/')[0],'cm',''));
									asknife=replaceAll(as[0].memo,'cm','').split('/');
								}
							}
						}
						for(var j=0;j<asknife.length;j++){
							if(asknife[j]==''){
								asknife.splice(j, 1);
								j--;
							}else{
								asknife[j]=dec(asknife[j]);
							}
						}
					}
					
					if(specsize.indexOf(tspec1+tsize1+'#')==-1){//已做過的相同材質號數 不在做一次
						specsize=specsize+tspec1+tsize1+'#';
						var cutlengthb=[];//相同材質號數的長度
						var cutlengthballs=[];//相同材質號數的長度內 根據最大長度 可誤差長度
						var maxcutlengthb='0'; //最大長度
						var maxcutlengthbs=[];//最大長度可誤差長度
						
						//讀取相同材質號數的長度
						cutlengthb=[];
						for (var j=0;j<t_same.length;j++){
							var tspec2=t_same[j].spec;
							var tsize2=t_same[j].size;
							var tmount2=t_same[j].mount;
							var lengthb2=dec(t_same[j].lengthb);
							if(tspec1==tspec2 && tsize1==tsize2 && dec(tmount2)>0){
								cutlengthb.push(lengthb2);
							}
						}
						
						//裁剪長度排序(最短,...,最長)
						cutlengthb.sort(function(a, b) {if(a>b) {return 1;} if (a < b) {return -1;} return 0;});
						maxcutlengthb=cutlengthb[cutlengthb.length-1];
						
						//107/01/30 可直接整除的長度先不選擇
						for(var m=cutlengthb.length-1;m>0;m--){
							var t_ismod=false;
							for(var k=0;k<t_cutsheet.length;k++){
								var clength=(dec(t_cutsheet[k])*100);
								if(clength%dec(maxcutlengthb)==0){
									if(m>0)
										maxcutlengthb=cutlengthb[m-1];
									t_ismod=true;
									break;
								}
							}
							if(!t_ismod){
								break;
							}
						}
						
						//裁切組合
						var t_cups=[];
						var t_cupsp=false;
						while(cutlengthb.length>0){//已排序過 
							//106/04/24一個項次裁剪完，再重新取得組合 求得最小損耗
							//106/09/14 不受項次限制
							t_cups=[];
							//可變動長度b-------------------------------------------------------
							maxcutlengthbs=[];
							cutlengthballs=[];
							for (var j=0;j<t_same.length;j++){
								var tspec2=t_same[j].spec;
								var tsize2=t_same[j].size;
								var lengthb2=dec(t_same[j].lengthb);
								if(tspec1==tspec2 && tsize1==tsize2 && lengthb2==maxcutlengthb){
									maxcutlengthbs.push(lengthb2);
									ttarray=[];
									tchglenc=0;
									cutlengthballs.push({
										maxlength:lengthb2,
										chgmaxlength:lengthb2,
										//陣列,材質,號數,最大長度,變動的最大長度,可使用長度
										cutlengthbs:samew03length(t_same,tspec1,tsize1,dec(t_same[j].lengthb),lengthb2,cutlengthb,[])
									});
										
									for (var k=0;k<t_same[j].data.length;k++){
										var ttw03=dec(t_same[j].data[k].tw03);
										lengthb2=dec(t_same[j].lengthb);
										while(ttw03>0){
											lengthb2=lengthb2-1;
											var existscutlens=false;
											for(var l=0;l<maxcutlengthbs.length;l++){
												if(maxcutlengthbs[l]==lengthb2){
													existscutlens=true;
													break;
												}
											}
											if(!existscutlens){
												maxcutlengthbs.push(lengthb2);
												ttarray=[];
												tchglenc=0;
												cutlengthballs.push({
													maxlength:dec(t_same[j].lengthb),
													chgmaxlength:lengthb2,
													//陣列,材質,號數,最大長度,變動的最大長度,可使用長度
													cutlengthbs:samew03length(t_same,tspec1,tsize1,dec(t_same[j].lengthb),lengthb2,cutlengthb,[])
												});
											}
											ttw03--;
										}
									}
									break;
								}
							}						
							//可變動長度e-------------------------------------------------------
							var bcount=0;
							for(var k=0;k<t_cutsheet.length;k++){
								var clength=(dec(t_cutsheet[k])*100); //原單位M
								if(sheetlength.indexOf(t_cutsheet[k])>-1){//要使用板料=設定中可用的裁剪板料
									bcount++;
									//106/04/20 調整可裁減長度
									var iswlenzero=false;
									for (var ml=0;ml<maxcutlengthbs.length;ml++){
										for (var mm=0;mm<cutlengthballs.length;mm++){
											if(maxcutlengthbs[ml]==cutlengthballs[mm].chgmaxlength){
												//最短裁剪長度限制
												for(var mx=0;mx<cutlengthballs[mm].cutlengthbs.length;mx++){
													cutlengthb=cutlengthballs[mm].cutlengthbs[mx];
													maxcutlengthb=maxcutlengthbs[ml];
									
													var cutlengthbs=[];
													var a_cutlengthbs=[];
													var b_cutlengthbs=[];
													var c_cutlengthbs=[];
													var d_cutlengthbs=[];
													var e_cutlengthbs=[];
													
													var t_maxlenmount=0;
													for (var j=0;j<t_same.length;j++){
														var tspec2=t_same[j].spec;
														var tsize2=t_same[j].size;
														var tmount2=t_same[j].mount;
														var lengthb2=dec(t_same[j].lengthb);
														if(tspec1==tspec2 && tsize1==tsize2 && dec(maxcutlengthb)==lengthb2 && dec(tmount2)>0){
																t_maxlenmount=dec(t_same[j].mount);
															break;
														}
													}
													var tmaxleng=(cutlengthb.length-1);
													//最大長度數量為1時不先處理
													while(t_maxlenmount<=1 && tmaxleng>-1){
														maxcutlengthb=cutlengthb[tmaxleng-1];
														for (var j=0;j<t_same.length;j++){
															var tspec2=t_same[j].spec;
															var tsize2=t_same[j].size;
															var tmount2=t_same[j].mount;
															var lengthb2=dec(t_same[j].lengthb);
															if(tspec1==tspec2 && tsize1==tsize2 && dec(maxcutlengthb)==lengthb2 && dec(tmount2)>0){
																	t_maxlenmount=dec(t_same[j].mount);
																break;
															}
														}
														
														tmaxleng--;
													}
													if(maxcutlengthb==undefined){
														maxcutlengthb=cutlengthb[cutlengthb.length-1];
													}
													
													//最短裁剪長度限制
													for(var n=0;n<cutlengthb.length;n++){
														if(dec(cutlengthb[n])!=dec(maxcutlengthb)){
															for (var j=0;j<t_same.length;j++){
																var tspec2=t_same[j].spec;
																var tsize2=t_same[j].size;
																var tmount2=t_same[j].mount;
																var lengthb2=dec(t_same[j].lengthb);
																if(tspec1==tspec2 && tsize1==tsize2 && dec(cutlengthb[n])==lengthb2 && dec(tmount2)>0){
																	if (t_maxlenmount==dec(t_same[j].mount)){
																		a_cutlengthbs.push(dec(cutlengthb[n]));
																	}else if (t_maxlenmount<dec(t_same[j].mount)){
																		b_cutlengthbs.push(dec(cutlengthb[n]));
																	}else if (t_maxlenmount%dec(t_same[j].mount)){
																		e_cutlengthbs.push(dec(cutlengthb[n]));
																	}else if(dec(cutlengthb[n])<dec(maxcutlengthb)){
																		d_cutlengthbs.push(dec(cutlengthb[n]));
																	}else{
																		c_cutlengthbs.push(dec(cutlengthb[n]));
																	}
																	
																	break;
																}
															}
														}
													}
													
													rep='';
													
													t_cupsp=false;
													//S1 數量相同
													cutlengthbs=$.extend(true,[], a_cutlengthbs);
													cutlengthbs.sort(function(a, b) {if(a>b) {return -1;} if (a < b) {return 1;} return 0;});//長>短
													var tmp2=$.extend(true,[], b_cutlengthbs);
													tmp2.sort(function(a, b) {if(a>b) {return -1;} if (a < b) {return 1;} return 0;});//長>短
													cutlengthbs=cutlengthbs=cutlengthbs.concat(tmp2);
													var t_cup=getmlength2(clength,clength,maxcutlengthb,cutlengthbs,'',[],t_same,tspec1,tsize1);
													
													//---------------------------------------
													//取得所需數量
													var tt_same=[],tmp_same=[];
													for(var n=0;n<t_same.length;n++){
														var tspec2=t_same[n].spec;
														var tsize2=t_same[n].size;
														var lengthb2=t_same[n].lengthb;
														var tdata2=t_same[n].data;
														if(tspec1==tspec2 && tsize1==tsize2){
															for(var m=0;m<tdata2.length;m++){
																if(dec(tdata2[m].mount)>0){
																	tt_same.push({
																		'maxmount':t_same[n].maxmount,
																		'lengthb':lengthb2,
																		'mount':tdata2[m].mount,
																		'nor':tdata2[m].nor,
																		'tw03':tdata2[m].tw03
																	});
																}
															}
														}
													}
													
													tmp_same=$.extend(true,[], tt_same);
													
													//調整最後剩餘數量是否符合最低損耗率
													for(var f=0;f<t_cup.length;f++){
														tt_same=$.extend(true,[], tmp_same);
														var cupcutlength=t_cup[f].cutlength.split('#')[0].split(',');//切割長度
														var cupcutwlength=dec(t_cup[f].cutlength.split('#')[1]);//損耗長度
														var cupolength=t_cup[f].olength;//裁剪的板料長度
														
														var cuttmp=[];//組合數量
														for (var m=0;m<cupcutlength.length;m++){//裁切數量
															var x_n=-1;
															for (var n=0;n<cuttmp.length;n++){
																if(cuttmp[n].lengthb==dec(cupcutlength[m])){
																	cuttmp[n].mount=cuttmp[n].mount+1;
																	x_n=n;
																	break;	
																}
															}
															if(x_n==-1){
																cuttmp.push({
																	'lengthb':dec(cupcutlength[m]),
																	'mount':1
																});
															}
														}
														var t_wlength=dec(cupolength);
														/*if(t_wlength.toString().slice(-1)=='5'){
															t_wlength=dec(t_wlength.toString().substr(0,t_wlength.toString().length-1)+'0');
														}*/
														
														var t_cutlength='';
														for (var m=0;m<cuttmp.length;m++){
															for (var n=0;n<tt_same.length;n++){
																if(dec(cuttmp[m].mount)>0 && dec(cuttmp[m].lengthb)<=dec(tt_same[n].lengthb) && dec(cuttmp[m].lengthb)>=(dec(tt_same[n].lengthb)-dec(tt_same[n].tw03))){
																	if(dec(cuttmp[m].mount)>dec(tt_same[n].mount)+dec(tt_same[n].maxmount)){
																		t_wlength=q_sub(t_wlength,q_mul(dec(cuttmp[m].lengthb),dec(tt_same[n].mount)+dec(tt_same[n].maxmount)));
																		var ttt_mount=dec(tt_same[n].mount)+dec(tt_same[n].maxmount);
																		while(ttt_mount>0){
																			t_cutlength=t_cutlength+(t_cutlength.length>0?',':'')+cuttmp[m].lengthb;
																			ttt_mount--;
																			cuttmp[m].mount=dec(cuttmp[m].mount)-1;
																			tt_same[n].mount=dec(tt_same[n].mount)-1;
																		}
																	}else{
																		t_wlength=q_sub(t_wlength,q_mul(dec(cuttmp[m].lengthb),cuttmp[m].mount));
																		var ttt_mount=cuttmp[m].mount;
																		while(ttt_mount>0){
																			t_cutlength=t_cutlength+(t_cutlength.length>0?',':'')+cuttmp[m].lengthb;
																			ttt_mount--;
																			cuttmp[m].mount=dec(cuttmp[m].mount)-1;
																			tt_same[n].mount=dec(tt_same[n].mount)-1;
																		}
																	}
																	//106/09/14 不受項次限制
																	//break;
																}
															}
														}
														if(t_wlength<0)
															t_wlength=0;
														t_cup[f].wlenhth=t_wlength;
														t_cup[f].wrate=t_wlength/dec(cupolength);
														t_cup[f].cutlength=t_cutlength+'#'+t_wlength;
														if(t_cup[f].wrate>0){
															t_cup.splice(f,1)
															f--;
														}else{
															//做兩支以上
															var cuttmp=[];//組合數量
															for (var m=0;m<cupcutlength.length;m++){//裁切數量
																var x_n=-1;
																for (var n=0;n<cuttmp.length;n++){
																	if(cuttmp[n].lengthb==dec(cupcutlength[m])){
																		cuttmp[n].mount=cuttmp[n].mount+1;
																		x_n=n;
																		break;	
																	}
																}
																if(x_n==-1){
																	cuttmp.push({
																		'lengthb':dec(cupcutlength[m]),
																		'mount':1
																	});
																}
															}
															var t_wlength=dec(cupolength);
															/*if(t_wlength.toString().slice(-1)=='5'){
																t_wlength=dec(t_wlength.toString().substr(0,t_wlength.toString().length-1)+'0');
															}*/
															
															var t_cutlength='';
															for (var m=0;m<cuttmp.length;m++){
																for (var n=0;n<tt_same.length;n++){
																	if(dec(cuttmp[m].mount)>0 && dec(cuttmp[m].lengthb)<=dec(tt_same[n].lengthb) && dec(cuttmp[m].lengthb)>=(dec(tt_same[n].lengthb)-dec(tt_same[n].tw03))){
																		if(dec(cuttmp[m].mount)>dec(tt_same[n].mount)+dec(tt_same[n].maxmount)){
																			t_wlength=q_sub(t_wlength,q_mul(dec(cuttmp[m].lengthb),dec(tt_same[n].mount)+dec(tt_same[n].maxmount)));
																			var ttt_mount=dec(tt_same[n].mount)+dec(tt_same[n].maxmount);
																			while(ttt_mount>0){
																				t_cutlength=t_cutlength+(t_cutlength.length>0?',':'')+cuttmp[m].lengthb;
																				ttt_mount--;
																				cuttmp[m].mount=dec(cuttmp[m].mount)-1;
																				tt_same[n].mount=dec(tt_same[n].mount)-1;
																			}
																		}else{
																			t_wlength=q_sub(t_wlength,q_mul(dec(cuttmp[m].lengthb),cuttmp[m].mount));
																			var ttt_mount=cuttmp[m].mount;
																			while(ttt_mount>0){
																				t_cutlength=t_cutlength+(t_cutlength.length>0?',':'')+cuttmp[m].lengthb;
																				ttt_mount--;
																				cuttmp[m].mount=dec(cuttmp[m].mount)-1;
																				tt_same[n].mount=dec(tt_same[n].mount)-1;
																			}
																		}
																		//106/09/14 不受項次限制
																		//break;
																	}
																}
															}
															if(t_wlength<0)
																t_wlength=0;
															//t_cup[f].wlenhth=t_wlength;
															t_cup[f].wrate=t_wlength/dec(cupolength);
															//t_cup[f].cutlength=t_cutlength+'#'+t_wlength;
															if(t_cup[f].wrate>0){
																t_cup.splice(f,1)
																f--;
															}
														}
													}
													
													//--------------------------------------
													
													//S2 長度小的數量要比長度大的數量大 之後取長度次長的不管數量
													if(t_cup.length==0){
														var tmp=$.extend(true,[], a_cutlengthbs);
														tmp=tmp.concat(b_cutlengthbs);
														tmp.sort(function(a, b) {if(a>b) {return 1;} if (a < b) {return -1;} return 0;});//短>長
														cutlengthbs=$.extend(true,[], [tmp[0]]);
														tmp.splice(0,1);
														tmp.sort(function(a, b) {if(a>b) {return -1;} if (a < b) {return 1;} return 0;});//長>短
														cutlengthbs=cutlengthbs.concat(tmp);
														cutlengthbs=cutlengthbs.concat(e_cutlengthbs);
														
														t_cup=getmlength2(clength,clength,maxcutlengthb,cutlengthbs,'',[],t_same,tspec1,tsize1);
													}else{
														t_cupsp=true;
													}
													
													//---------------------------------------
													//取得所需數量
													var tt_same=[],tmp_same=[];
													for(var n=0;n<t_same.length;n++){
														var tspec2=t_same[n].spec;
														var tsize2=t_same[n].size;
														var lengthb2=t_same[n].lengthb;
														var tdata2=t_same[n].data;
														if(tspec1==tspec2 && tsize1==tsize2){
															for(var m=0;m<tdata2.length;m++){
																if(dec(tdata2[m].mount)>0){
																	tt_same.push({
																		'maxmount':t_same[n].maxmount,
																		'lengthb':lengthb2,
																		'mount':tdata2[m].mount,
																		'nor':tdata2[m].nor,
																		'tw03':tdata2[m].tw03
																	});
																}
															}
														}
													}
													tmp_same=$.extend(true,[], tt_same);
													//調整最後剩餘數量是否符合最低損耗率
													for(var f=0;f<t_cup.length;f++){
														tt_same=$.extend(true,[], tmp_same);
														var cupcutlength=t_cup[f].cutlength.split('#')[0].split(',');//切割長度
														var cupcutwlength=dec(t_cup[f].cutlength.split('#')[1]);//損耗長度
														var cupolength=t_cup[f].olength;//裁剪的板料長度
														
														var cuttmp=[];//組合數量
														for (var m=0;m<cupcutlength.length;m++){//裁切數量
															var x_n=-1;
															for (var n=0;n<cuttmp.length;n++){
																if(cuttmp[n].lengthb==dec(cupcutlength[m])){
																	cuttmp[n].mount=cuttmp[n].mount+1;
																	x_n=n;
																	break;	
																}
															}
															if(x_n==-1){
																cuttmp.push({
																	'lengthb':dec(cupcutlength[m]),
																	'mount':1
																});
															}
														}
														var t_wlength=dec(cupolength);
														/*if(t_wlength.toString().slice(-1)=='5'){
															t_wlength=dec(t_wlength.toString().substr(0,t_wlength.toString().length-1)+'0');
														}*/
														
														var t_cutlength='';
														for (var m=0;m<cuttmp.length;m++){
															for (var n=0;n<tt_same.length;n++){
																if(dec(cuttmp[m].mount)>0 && dec(cuttmp[m].lengthb)<=dec(tt_same[n].lengthb) && dec(cuttmp[m].lengthb)>=(dec(tt_same[n].lengthb)-dec(tt_same[n].tw03))){
																	if(dec(cuttmp[m].mount)>dec(tt_same[n].mount)+dec(tt_same[n].maxmount)){
																		t_wlength=q_sub(t_wlength,q_mul(dec(cuttmp[m].lengthb),dec(tt_same[n].mount)+dec(tt_same[n].maxmount)));
																		var ttt_mount=dec(tt_same[n].mount)+dec(tt_same[n].maxmount);
																		while(ttt_mount>0){
																			t_cutlength=t_cutlength+(t_cutlength.length>0?',':'')+cuttmp[m].lengthb;
																			ttt_mount--;
																			cuttmp[m].mount=dec(cuttmp[m].mount)-1;
																			tt_same[n].mount=dec(tt_same[n].mount)-1;
																		}
																	}else{
																		t_wlength=q_sub(t_wlength,q_mul(dec(cuttmp[m].lengthb),cuttmp[m].mount));
																		var ttt_mount=cuttmp[m].mount;
																		while(ttt_mount>0){
																			t_cutlength=t_cutlength+(t_cutlength.length>0?',':'')+cuttmp[m].lengthb;
																			ttt_mount--;
																			cuttmp[m].mount=dec(cuttmp[m].mount)-1;
																			tt_same[n].mount=dec(tt_same[n].mount)-1;
																		}
																	}
																	//106/09/14 不受項次限制
																	//break;
																}
															}
														}
														if(t_wlength<0)
															t_wlength=0;
														t_cup[f].wlenhth=t_wlength;
														t_cup[f].wrate=t_wlength/dec(cupolength);
														t_cup[f].cutlength=t_cutlength+'#'+t_wlength;
														if(t_cup[f].wrate>0){
															t_cup.splice(f,1)
															f--;
														}else{
															//做兩支以上
															var cuttmp=[];//組合數量
															for (var m=0;m<cupcutlength.length;m++){//裁切數量
																var x_n=-1;
																for (var n=0;n<cuttmp.length;n++){
																	if(cuttmp[n].lengthb==dec(cupcutlength[m])){
																		cuttmp[n].mount=cuttmp[n].mount+1;
																		x_n=n;
																		break;	
																	}
																}
																if(x_n==-1){
																	cuttmp.push({
																		'lengthb':dec(cupcutlength[m]),
																		'mount':1
																	});
																}
															}
															var t_wlength=dec(cupolength);
															/*if(t_wlength.toString().slice(-1)=='5'){
																t_wlength=dec(t_wlength.toString().substr(0,t_wlength.toString().length-1)+'0');
															}*/
															
															var t_cutlength='';
															for (var m=0;m<cuttmp.length;m++){
																for (var n=0;n<tt_same.length;n++){
																	if(dec(cuttmp[m].mount)>0 && dec(cuttmp[m].lengthb)<=dec(tt_same[n].lengthb) && dec(cuttmp[m].lengthb)>=(dec(tt_same[n].lengthb)-dec(tt_same[n].tw03))){
																		if(dec(cuttmp[m].mount)>dec(tt_same[n].mount)+dec(tt_same[n].maxmount)){
																			t_wlength=q_sub(t_wlength,q_mul(dec(cuttmp[m].lengthb),dec(tt_same[n].mount)+dec(tt_same[n].maxmount)));
																			var ttt_mount=dec(tt_same[n].mount)+dec(tt_same[n].maxmount);
																			while(ttt_mount>0){
																				t_cutlength=t_cutlength+(t_cutlength.length>0?',':'')+cuttmp[m].lengthb;
																				ttt_mount--;
																				cuttmp[m].mount=dec(cuttmp[m].mount)-1;
																				tt_same[n].mount=dec(tt_same[n].mount)-1;
																			}
																		}else{
																			t_wlength=q_sub(t_wlength,q_mul(dec(cuttmp[m].lengthb),cuttmp[m].mount));
																			var ttt_mount=cuttmp[m].mount;
																			while(ttt_mount>0){
																				t_cutlength=t_cutlength+(t_cutlength.length>0?',':'')+cuttmp[m].lengthb;
																				ttt_mount--;
																				cuttmp[m].mount=dec(cuttmp[m].mount)-1;
																				tt_same[n].mount=dec(tt_same[n].mount)-1;
																			}
																		}
																		//106/09/14 不受項次限制
																		//break;
																	}
																}
															}
															if(t_wlength<0)
																t_wlength=0;
															//t_cup[f].wlenhth=t_wlength;
															t_cup[f].wrate=t_wlength/dec(cupolength);
															//t_cup[f].cutlength=t_cutlength+'#'+t_wlength;
															if(t_cup[f].wrate>0){
																t_cup.splice(f,1)
																f--;
															}
														}
													}
													
													//--------------------------------------
													
													//沒有其他組合選自己或更少的數量
													
													if(t_cup.length==0){
														rep='';
														//cutlengthbs=$.extend(true,[], b_cutlengthbs);//數量多
														cutlengthbs=cutlengthbs.concat([dec(maxcutlengthb)]);
														cutlengthbs=cutlengthbs.concat(c_cutlengthbs);//數量少
														cutlengthbs=cutlengthbs.concat(d_cutlengthbs);//長度短 且數量少
														t_cup=getmlength(clength,clength,maxcutlengthb,cutlengthbs,'',[],t_same,tspec1,tsize1,t_stlen);
													}else{
														t_cupsp=true;
													}
													
													//---------------------------------------
													//取得所需數量
													var tt_same=[],tmp_same=[];
													for(var n=0;n<t_same.length;n++){
														var tspec2=t_same[n].spec;
														var tsize2=t_same[n].size;
														var lengthb2=t_same[n].lengthb;
														var tdata2=t_same[n].data;
														if(tspec1==tspec2 && tsize1==tsize2){
															for(var m=0;m<tdata2.length;m++){
																if(dec(tdata2[m].mount)>0){
																	tt_same.push({
																		'maxmount':t_same[n].maxmount,
																		'lengthb':lengthb2,
																		'mount':tdata2[m].mount,
																		'nor':tdata2[m].nor,
																		'tw03':tdata2[m].tw03
																	});
																}
															}
														}
													}
													tmp_same=$.extend(true,[], tt_same);
													//調整最後剩餘數量是否符合最低損耗率
													for(var f=0;f<t_cup.length;f++){
														tt_same=$.extend(true,[], tmp_same);
														var cupcutlength=t_cup[f].cutlength.split('#')[0].split(',');//切割長度
														var cupcutwlength=dec(t_cup[f].cutlength.split('#')[1]);//損耗長度
														var cupolength=t_cup[f].olength;//裁剪的板料長度
														
														var cuttmp=[];//組合數量
														for (var m=0;m<cupcutlength.length;m++){//裁切數量
															var x_n=-1;
															for (var n=0;n<cuttmp.length;n++){
																if(cuttmp[n].lengthb==dec(cupcutlength[m])){
																	cuttmp[n].mount=cuttmp[n].mount+1;
																	x_n=n;
																	break;	
																}
															}
															if(x_n==-1){
																cuttmp.push({
																	'lengthb':dec(cupcutlength[m]),
																	'mount':1
																});
															}
														}
														var t_wlength=dec(cupolength);
														/*if(t_wlength.toString().slice(-1)=='5'){
															t_wlength=dec(t_wlength.toString().substr(0,t_wlength.toString().length-1)+'0');
														}*/
														
														var t_cutlength='';
														for (var m=0;m<cuttmp.length;m++){
															for (var n=0;n<tt_same.length;n++){
																if(dec(cuttmp[m].mount)>0 && dec(cuttmp[m].lengthb)<=dec(tt_same[n].lengthb) && dec(cuttmp[m].lengthb)>=(dec(tt_same[n].lengthb)-dec(tt_same[n].tw03))){
																	if(dec(cuttmp[m].mount)>dec(tt_same[n].mount)+dec(tt_same[n].maxmount)){
																		t_wlength=q_sub(t_wlength,q_mul(dec(cuttmp[m].lengthb),dec(tt_same[n].mount)+dec(tt_same[n].maxmount)));
																		var ttt_mount=dec(tt_same[n].mount)+dec(tt_same[n].maxmount);
																		while(ttt_mount>0){
																			t_cutlength=t_cutlength+(t_cutlength.length>0?',':'')+cuttmp[m].lengthb;
																			ttt_mount--;
																			cuttmp[m].mount=dec(cuttmp[m].mount)-1;
																			tt_same[n].mount=dec(tt_same[n].mount)-1;
																		}
																	}else{
																		t_wlength=q_sub(t_wlength,q_mul(dec(cuttmp[m].lengthb),cuttmp[m].mount));
																		var ttt_mount=cuttmp[m].mount;
																		while(ttt_mount>0){
																			t_cutlength=t_cutlength+(t_cutlength.length>0?',':'')+cuttmp[m].lengthb;
																			ttt_mount--;
																			cuttmp[m].mount=dec(cuttmp[m].mount)-1;
																			tt_same[n].mount=dec(tt_same[n].mount)-1;
																		}
																	}
																	//106/09/14 不受項次限制
																	//break;
																}
															}
														}
														if(t_wlength<0)
															t_wlength=0;
														t_cup[f].wlenhth=t_wlength;
														t_cup[f].wrate=t_wlength/dec(cupolength);
														t_cup[f].cutlength=t_cutlength+'#'+t_wlength;
														if(t_cup[f].wrate>0){
															t_cup.splice(f,1);
															f--;
														}else{
															//做兩支以上
															var cuttmp=[];//組合數量
															for (var m=0;m<cupcutlength.length;m++){//裁切數量
																var x_n=-1;
																for (var n=0;n<cuttmp.length;n++){
																	if(cuttmp[n].lengthb==dec(cupcutlength[m])){
																		cuttmp[n].mount=cuttmp[n].mount+1;
																		x_n=n;
																		break;	
																	}
																}
																if(x_n==-1){
																	cuttmp.push({
																		'lengthb':dec(cupcutlength[m]),
																		'mount':1
																	});
																}
															}
															var t_wlength=dec(cupolength);
															/*if(t_wlength.toString().slice(-1)=='5'){
																t_wlength=dec(t_wlength.toString().substr(0,t_wlength.toString().length-1)+'0');
															}*/
															
															var t_cutlength='';
															for (var m=0;m<cuttmp.length;m++){
																for (var n=0;n<tt_same.length;n++){
																	if(dec(cuttmp[m].mount)>0 && dec(cuttmp[m].lengthb)<=dec(tt_same[n].lengthb) && dec(cuttmp[m].lengthb)>=(dec(tt_same[n].lengthb)-dec(tt_same[n].tw03))){
																		if(dec(cuttmp[m].mount)>dec(tt_same[n].mount)+dec(tt_same[n].maxmount)){
																			t_wlength=q_sub(t_wlength,q_mul(dec(cuttmp[m].lengthb),dec(tt_same[n].mount)+dec(tt_same[n].maxmount)));
																			var ttt_mount=dec(tt_same[n].mount)+dec(tt_same[n].maxmount);
																			while(ttt_mount>0){
																				t_cutlength=t_cutlength+(t_cutlength.length>0?',':'')+cuttmp[m].lengthb;
																				ttt_mount--;
																				cuttmp[m].mount=dec(cuttmp[m].mount)-1;
																				tt_same[n].mount=dec(tt_same[n].mount)-1;
																			}
																		}else{
																			t_wlength=q_sub(t_wlength,q_mul(dec(cuttmp[m].lengthb),cuttmp[m].mount));
																			var ttt_mount=cuttmp[m].mount;
																			while(ttt_mount>0){
																				t_cutlength=t_cutlength+(t_cutlength.length>0?',':'')+cuttmp[m].lengthb;
																				ttt_mount--;
																				cuttmp[m].mount=dec(cuttmp[m].mount)-1;
																				tt_same[n].mount=dec(tt_same[n].mount)-1;
																			}
																		}
																		//106/09/14 不受項次限制
																		//break;
																	}
																}
															}
															if(t_wlength<0)
																t_wlength=0;
															//t_cup[f].wlenhth=t_wlength;
															t_cup[f].wrate=t_wlength/dec(cupolength);
															//t_cup[f].cutlength=t_cutlength+'#'+t_wlength;
															if(t_cup[f].wrate>0){
																t_cup.splice(f,1);
																f--;
															}
														}
													}
													
													if(t_cup.length==0){
														//cutlengthbs.sort(function(a, b) {if(a>b) {return -1;} if (a < b) {return 1;} return 0;});//長>短
														rep='';
														cutlengthbs=[];
														a_cutlengthbs=[];
														b_cutlengthbs=[];
														c_cutlengthbs=[];
														d_cutlengthbs=[];
														e_cutlengthbs=[];
																								
														//最短裁剪長度限制
														for(var n=0;n<cutlengthb.length;n++){
															if(dec(cutlengthb[n])!=dec(maxcutlengthb)){
																for (var j=0;j<t_same.length;j++){
																	var tspec2=t_same[j].spec;
																	var tsize2=t_same[j].size;
																	var tmount2=t_same[j].mount;
																	var lengthb2=dec(t_same[j].lengthb);
																	if(tspec1==tspec2 && tsize1==tsize2 && dec(cutlengthb[n])==lengthb2 && dec(tmount2)>0){
																		if (t_maxlenmount==dec(t_same[j].mount)){
																			a_cutlengthbs.push(dec(cutlengthb[n]));
																		}else if (t_maxlenmount<dec(t_same[j].mount)){
																			b_cutlengthbs.push(dec(cutlengthb[n]));
																		}else if (t_maxlenmount%dec(t_same[j].mount)){
																			e_cutlengthbs.push(dec(cutlengthb[n]));
																		}else if(dec(t_same[j].mount)==1){
																			d_cutlengthbs.push(dec(cutlengthb[n]));
																		}else{
																			c_cutlengthbs.push(dec(cutlengthb[n]));
																		}
																		
																		break;
																	}
																}
															}
														}
														cutlengthbs=$.extend(true,[], [dec(maxcutlengthb)]);
														cutlengthbs=cutlengthbs.concat(a_cutlengthbs);//數量相同
														cutlengthbs=cutlengthbs.concat(b_cutlengthbs);//數量多
														cutlengthbs=cutlengthbs.concat(e_cutlengthbs); //數量少 倍數
														cutlengthbs=cutlengthbs.concat(c_cutlengthbs);//數量少
														cutlengthbs=cutlengthbs.concat(d_cutlengthbs);//數量1
														
														t_cup=getmlength(clength,clength,maxcutlengthb,cutlengthbs,'',[],t_same,tspec1,tsize1,t_stlen);
													}else{
														t_cupsp=true;
													}
													
													//排序
													t_cup.sort(function(a, b) { if(a.wrate > b.wrate) {return 1;} if (a.wrate < b.wrate) {return -1;}if(a.cutlength.split(',').length>b.cutlength.split(',').length) {return 1;}if(a.cutlength.split(',').length<b.cutlength.split(',').length) {return -1;}return 0;});
													t_cups=t_cups.concat(t_cup);
													
													//106/05/10 取到最無損號就不計算可誤差
													if(t_cup.length>0){
														if(t_cup[0].wlenhth==0){
															iswlenzero=true;
															break;
														}													
													}
												}
											}
											if(iswlenzero){break;}
										}
										if(iswlenzero){break;}
									}
								}
								
								t_cups.sort(function(a, b) {
									if(a.wrate > b.wrate) {return 1;} 
									if(a.wrate < b.wrate) {return -1;}
									return 0;
								});
								
								//107/02/01 若原長度已有最好組合衍伸長度就不做組合
								var t_levc=true;
								if(t_cups.length>0){
									if(t_cups[0].wrate==0){
										t_levc=false;
									}
								}
								
								if(dec($('#txtLevel').val())>0 && t_levc){
									var t_level=dec($('#txtLevel').val());
									if (t_level>0){
										clength=(dec(t_cutsheet[k])*100)+t_level; //原單位M
										if(sheetlength.indexOf(t_cutsheet[k])>-1){//要使用板料=設定中可用的裁剪板料
											bcount++;
											//106/04/20 調整可裁減長度
											var iswlenzero=false;
											for (var ml=0;ml<maxcutlengthbs.length;ml++){
												for (var mm=0;mm<cutlengthballs.length;mm++){
													if(maxcutlengthbs[ml]==cutlengthballs[mm].chgmaxlength){
														//最短裁剪長度限制
														for(var mx=0;mx<cutlengthballs[mm].cutlengthbs.length;mx++){
															cutlengthb=cutlengthballs[mm].cutlengthbs[mx];
															maxcutlengthb=maxcutlengthbs[ml];
											
															var cutlengthbs=[];
															var a_cutlengthbs=[];
															var b_cutlengthbs=[];
															var c_cutlengthbs=[];
															var d_cutlengthbs=[];
															var e_cutlengthbs=[];
															
															var t_maxlenmount=0;
															for (var j=0;j<t_same.length;j++){
																var tspec2=t_same[j].spec;
																var tsize2=t_same[j].size;
																var tmount2=t_same[j].mount;
																var lengthb2=dec(t_same[j].lengthb);
																if(tspec1==tspec2 && tsize1==tsize2 && dec(maxcutlengthb)==lengthb2 && dec(tmount2)>0){
																		t_maxlenmount=dec(t_same[j].mount);
																	break;
																}
															}
															
															//最短裁剪長度限制
															for(var n=0;n<cutlengthb.length;n++){
																if(dec(cutlengthb[n])!=dec(maxcutlengthb)){
																	for (var j=0;j<t_same.length;j++){
																		var tspec2=t_same[j].spec;
																		var tsize2=t_same[j].size;
																		var tmount2=t_same[j].mount;
																		var lengthb2=dec(t_same[j].lengthb);
																		if(tspec1==tspec2 && tsize1==tsize2 && dec(cutlengthb[n])==lengthb2 && dec(tmount2)>0){
																			if (t_maxlenmount==dec(t_same[j].mount)){
																				a_cutlengthbs.push(dec(cutlengthb[n]));
																			}else if (t_maxlenmount<dec(t_same[j].mount)){
																				b_cutlengthbs.push(dec(cutlengthb[n]));
																			}else if (t_maxlenmount%dec(t_same[j].mount)){
																				e_cutlengthbs.push(dec(cutlengthb[n]));
																			}else if(dec(cutlengthb[n])<dec(maxcutlengthb)){
																				d_cutlengthbs.push(dec(cutlengthb[n]));
																			}else{
																				c_cutlengthbs.push(dec(cutlengthb[n]));
																			}
																			
																			break;
																		}
																	}
																}
															}
															
															rep='';
															
															t_cupsp=false;
															//S1 數量相同
															cutlengthbs=$.extend(true,[], a_cutlengthbs);
															cutlengthbs.sort(function(a, b) {if(a>b) {return -1;} if (a < b) {return 1;} return 0;});//長>短
															var tmp2=$.extend(true,[], b_cutlengthbs);
															tmp2.sort(function(a, b) {if(a>b) {return -1;} if (a < b) {return 1;} return 0;});//長>短
															cutlengthbs=cutlengthbs=cutlengthbs.concat(tmp2);
															var t_cup=getmlength2(clength,clength,maxcutlengthb,cutlengthbs,'',[],t_same,tspec1,tsize1);
															
															//---------------------------------------
															//取得所需數量
															var tt_same=[],tmp_same=[];
															for(var n=0;n<t_same.length;n++){
																var tspec2=t_same[n].spec;
																var tsize2=t_same[n].size;
																var lengthb2=t_same[n].lengthb;
																var tdata2=t_same[n].data;
																if(tspec1==tspec2 && tsize1==tsize2){
																	for(var m=0;m<tdata2.length;m++){
																		if(dec(tdata2[m].mount)>0){
																			tt_same.push({
																				'maxmount':t_same[n].maxmount,
																				'lengthb':lengthb2,
																				'mount':tdata2[m].mount,
																				'nor':tdata2[m].nor,
																				'tw03':tdata2[m].tw03
																			});
																		}
																	}
																}
															}
															tmp_same=$.extend(true,[], tt_same);
															//調整最後剩餘數量是否符合最低損耗率
															for(var f=0;f<t_cup.length;f++){
																tt_same=$.extend(true,[], tmp_same);
																var cupcutlength=t_cup[f].cutlength.split('#')[0].split(',');//切割長度
																var cupcutwlength=dec(t_cup[f].cutlength.split('#')[1]);//損耗長度
																var cupolength=t_cup[f].olength;//裁剪的板料長度
																
																var cuttmp=[];//組合數量
																for (var m=0;m<cupcutlength.length;m++){//裁切數量
																	var x_n=-1;
																	for (var n=0;n<cuttmp.length;n++){
																		if(cuttmp[n].lengthb==dec(cupcutlength[m])){
																			cuttmp[n].mount=cuttmp[n].mount+1;
																			x_n=n;
																			break;	
																		}
																	}
																	if(x_n==-1){
																		cuttmp.push({
																			'lengthb':dec(cupcutlength[m]),
																			'mount':1
																		});
																	}
																}
																var t_wlength=dec(cupolength);
																/*if(t_wlength.toString().slice(-1)=='5'){
																	t_wlength=dec(t_wlength.toString().substr(0,t_wlength.toString().length-1)+'0');
																}*/
																
																var t_cutlength='';
																for (var m=0;m<cuttmp.length;m++){
																	for (var n=0;n<tt_same.length;n++){
																		if(dec(cuttmp[m].mount)>0 && dec(cuttmp[m].lengthb)<=dec(tt_same[n].lengthb) && dec(cuttmp[m].lengthb)>=(dec(tt_same[n].lengthb)-dec(tt_same[n].tw03))){
																			if(dec(cuttmp[m].mount)>dec(tt_same[n].mount)+dec(tt_same[n].maxmount)){
																				t_wlength=q_sub(t_wlength,q_mul(dec(cuttmp[m].lengthb),dec(tt_same[n].mount)+dec(tt_same[n].maxmount)));
																				var ttt_mount=dec(tt_same[n].mount)+dec(tt_same[n].maxmount);
																				while(ttt_mount>0){
																					t_cutlength=t_cutlength+(t_cutlength.length>0?',':'')+cuttmp[m].lengthb;
																					ttt_mount--;
																					cuttmp[m].mount=dec(cuttmp[m].mount)-1;
																					tt_same[n].mount=dec(tt_same[n].mount)-1;
																				}
																			}else{
																				t_wlength=q_sub(t_wlength,q_mul(dec(cuttmp[m].lengthb),cuttmp[m].mount));
																				var ttt_mount=cuttmp[m].mount;
																				while(ttt_mount>0){
																					t_cutlength=t_cutlength+(t_cutlength.length>0?',':'')+cuttmp[m].lengthb;
																					ttt_mount--;
																					cuttmp[m].mount=dec(cuttmp[m].mount)-1;
																					tt_same[n].mount=dec(tt_same[n].mount)-1;
																				}
																			}
																			//106/09/14 不受項次限制
																			//break;
																		}
																	}
																}
																if(t_wlength<0)
																	t_wlength=0;
																t_cup[f].wlenhth=t_wlength;
																t_cup[f].wrate=t_wlength/dec(cupolength);
																t_cup[f].cutlength=t_cutlength+'#'+t_wlength;
																if(t_cup[f].wrate>0){
																	t_cup.splice(f,1)
																	f--;
																}else{
																	//做兩支以上
																	var cuttmp=[];//組合數量
																	for (var m=0;m<cupcutlength.length;m++){//裁切數量
																		var x_n=-1;
																		for (var n=0;n<cuttmp.length;n++){
																			if(cuttmp[n].lengthb==dec(cupcutlength[m])){
																				cuttmp[n].mount=cuttmp[n].mount+1;
																				x_n=n;
																				break;	
																			}
																		}
																		if(x_n==-1){
																			cuttmp.push({
																				'lengthb':dec(cupcutlength[m]),
																				'mount':1
																			});
																		}
																	}
																	var t_wlength=dec(cupolength);
																	/*if(t_wlength.toString().slice(-1)=='5'){
																		t_wlength=dec(t_wlength.toString().substr(0,t_wlength.toString().length-1)+'0');
																	}*/
																	
																	var t_cutlength='';
																	for (var m=0;m<cuttmp.length;m++){
																		for (var n=0;n<tt_same.length;n++){
																			if(dec(cuttmp[m].mount)>0 && dec(cuttmp[m].lengthb)<=dec(tt_same[n].lengthb) && dec(cuttmp[m].lengthb)>=(dec(tt_same[n].lengthb)-dec(tt_same[n].tw03))){
																				if(dec(cuttmp[m].mount)>dec(tt_same[n].mount)+dec(tt_same[n].maxmount)){
																					t_wlength=q_sub(t_wlength,q_mul(dec(cuttmp[m].lengthb),dec(tt_same[n].mount)+dec(tt_same[n].maxmount)));
																					var ttt_mount=dec(tt_same[n].mount)+dec(tt_same[n].maxmount);
																					while(ttt_mount>0){
																						t_cutlength=t_cutlength+(t_cutlength.length>0?',':'')+cuttmp[m].lengthb;
																						ttt_mount--;
																						cuttmp[m].mount=dec(cuttmp[m].mount)-1;
																						tt_same[n].mount=dec(tt_same[n].mount)-1;
																					}
																				}else{
																					t_wlength=q_sub(t_wlength,q_mul(dec(cuttmp[m].lengthb),cuttmp[m].mount));
																					var ttt_mount=cuttmp[m].mount;
																					while(ttt_mount>0){
																						t_cutlength=t_cutlength+(t_cutlength.length>0?',':'')+cuttmp[m].lengthb;
																						ttt_mount--;
																						cuttmp[m].mount=dec(cuttmp[m].mount)-1;
																						tt_same[n].mount=dec(tt_same[n].mount)-1;
																					}
																				}
																				//106/09/14 不受項次限制
																				//break;
																			}
																		}
																	}
																	if(t_wlength<0)
																		t_wlength=0;
																	//t_cup[f].wlenhth=t_wlength;
																	t_cup[f].wrate=t_wlength/dec(cupolength);
																	//t_cup[f].cutlength=t_cutlength+'#'+t_wlength;
																	if(t_cup[f].wrate>0){
																		t_cup.splice(f,1)
																		f--;
																	}
																}
															}
															
															//--------------------------------------
															
															//S2 長度小的數量要比長度大的數量大 之後取長度次長的不管數量
															if(t_cup.length==0){
																var tmp=$.extend(true,[], a_cutlengthbs);
																tmp=tmp.concat(b_cutlengthbs);
																tmp.sort(function(a, b) {if(a>b) {return 1;} if (a < b) {return -1;} return 0;});//短>長
																cutlengthbs=$.extend(true,[], [tmp[0]]);
																tmp.splice(0,1);
																tmp.sort(function(a, b) {if(a>b) {return -1;} if (a < b) {return 1;} return 0;});//長>短
																cutlengthbs=cutlengthbs.concat(tmp);
																cutlengthbs=cutlengthbs.concat(e_cutlengthbs);
																
																t_cup=getmlength2(clength,clength,maxcutlengthb,cutlengthbs,'',[],t_same,tspec1,tsize1);
															}else{
																t_cupsp=true;
															}
															
															//---------------------------------------
															//取得所需數量
															var tt_same=[],tmp_same=[];
															for(var n=0;n<t_same.length;n++){
																var tspec2=t_same[n].spec;
																var tsize2=t_same[n].size;
																var lengthb2=t_same[n].lengthb;
																var tdata2=t_same[n].data;
																if(tspec1==tspec2 && tsize1==tsize2){
																	for(var m=0;m<tdata2.length;m++){
																		if(dec(tdata2[m].mount)>0){
																			tt_same.push({
																				'maxmount':t_same[n].maxmount,
																				'lengthb':lengthb2,
																				'mount':tdata2[m].mount,
																				'nor':tdata2[m].nor,
																				'tw03':tdata2[m].tw03
																			});
																		}
																	}
																}
															}
															tmp_same=$.extend(true,[], tt_same);
															//調整最後剩餘數量是否符合最低損耗率
															for(var f=0;f<t_cup.length;f++){
																tt_same=$.extend(true,[], tmp_same);
																var cupcutlength=t_cup[f].cutlength.split('#')[0].split(',');//切割長度
																var cupcutwlength=dec(t_cup[f].cutlength.split('#')[1]);//損耗長度
																var cupolength=t_cup[f].olength;//裁剪的板料長度
																
																var cuttmp=[];//組合數量
																for (var m=0;m<cupcutlength.length;m++){//裁切數量
																	var x_n=-1;
																	for (var n=0;n<cuttmp.length;n++){
																		if(cuttmp[n].lengthb==dec(cupcutlength[m])){
																			cuttmp[n].mount=cuttmp[n].mount+1;
																			x_n=n;
																			break;	
																		}
																	}
																	if(x_n==-1){
																		cuttmp.push({
																			'lengthb':dec(cupcutlength[m]),
																			'mount':1
																		});
																	}
																}
																var t_wlength=dec(cupolength);
																/*if(t_wlength.toString().slice(-1)=='5'){
																	t_wlength=dec(t_wlength.toString().substr(0,t_wlength.toString().length-1)+'0');
																}*/
																
																var t_cutlength='';
																for (var m=0;m<cuttmp.length;m++){
																	for (var n=0;n<tt_same.length;n++){
																		if(dec(cuttmp[m].mount)>0 && dec(cuttmp[m].lengthb)<=dec(tt_same[n].lengthb) && dec(cuttmp[m].lengthb)>=(dec(tt_same[n].lengthb)-dec(tt_same[n].tw03))){
																			if(dec(cuttmp[m].mount)>dec(tt_same[n].mount)+dec(tt_same[n].maxmount)){
																				t_wlength=q_sub(t_wlength,q_mul(dec(cuttmp[m].lengthb),dec(tt_same[n].mount)+dec(tt_same[n].maxmount)));
																				var ttt_mount=dec(tt_same[n].mount)+dec(tt_same[n].maxmount);
																				while(ttt_mount>0){
																					t_cutlength=t_cutlength+(t_cutlength.length>0?',':'')+cuttmp[m].lengthb;
																					ttt_mount--;
																					cuttmp[m].mount=dec(cuttmp[m].mount)-1;
																					tt_same[n].mount=dec(tt_same[n].mount)-1;
																				}
																			}else{
																				t_wlength=q_sub(t_wlength,q_mul(dec(cuttmp[m].lengthb),cuttmp[m].mount));
																				var ttt_mount=cuttmp[m].mount;
																				while(ttt_mount>0){
																					t_cutlength=t_cutlength+(t_cutlength.length>0?',':'')+cuttmp[m].lengthb;
																					ttt_mount--;
																					cuttmp[m].mount=dec(cuttmp[m].mount)-1;
																					tt_same[n].mount=dec(tt_same[n].mount)-1;
																				}
																			}
																			//106/09/14 不受項次限制
																			//break;
																		}
																	}
																}
																if(t_wlength<0)
																	t_wlength=0;
																t_cup[f].wlenhth=t_wlength;
																t_cup[f].wrate=t_wlength/dec(cupolength);
																t_cup[f].cutlength=t_cutlength+'#'+t_wlength;
																if(t_cup[f].wrate>0){
																	t_cup.splice(f,1)
																	f--;
																}else{
																	//做兩支以上
																	var cuttmp=[];//組合數量
																	for (var m=0;m<cupcutlength.length;m++){//裁切數量
																		var x_n=-1;
																		for (var n=0;n<cuttmp.length;n++){
																			if(cuttmp[n].lengthb==dec(cupcutlength[m])){
																				cuttmp[n].mount=cuttmp[n].mount+1;
																				x_n=n;
																				break;	
																			}
																		}
																		if(x_n==-1){
																			cuttmp.push({
																				'lengthb':dec(cupcutlength[m]),
																				'mount':1
																			});
																		}
																	}
																	var t_wlength=dec(cupolength);
																	/*if(t_wlength.toString().slice(-1)=='5'){
																		t_wlength=dec(t_wlength.toString().substr(0,t_wlength.toString().length-1)+'0');
																	}*/
																	
																	var t_cutlength='';
																	for (var m=0;m<cuttmp.length;m++){
																		for (var n=0;n<tt_same.length;n++){
																			if(dec(cuttmp[m].mount)>0 && dec(cuttmp[m].lengthb)<=dec(tt_same[n].lengthb) && dec(cuttmp[m].lengthb)>=(dec(tt_same[n].lengthb)-dec(tt_same[n].tw03))){
																				if(dec(cuttmp[m].mount)>dec(tt_same[n].mount)+dec(tt_same[n].maxmount)){
																					t_wlength=q_sub(t_wlength,q_mul(dec(cuttmp[m].lengthb),dec(tt_same[n].mount)+dec(tt_same[n].maxmount)));
																					var ttt_mount=dec(tt_same[n].mount)+dec(tt_same[n].maxmount);
																					while(ttt_mount>0){
																						t_cutlength=t_cutlength+(t_cutlength.length>0?',':'')+cuttmp[m].lengthb;
																						ttt_mount--;
																						cuttmp[m].mount=dec(cuttmp[m].mount)-1;
																						tt_same[n].mount=dec(tt_same[n].mount)-1;
																					}
																				}else{
																					t_wlength=q_sub(t_wlength,q_mul(dec(cuttmp[m].lengthb),cuttmp[m].mount));
																					var ttt_mount=cuttmp[m].mount;
																					while(ttt_mount>0){
																						t_cutlength=t_cutlength+(t_cutlength.length>0?',':'')+cuttmp[m].lengthb;
																						ttt_mount--;
																						cuttmp[m].mount=dec(cuttmp[m].mount)-1;
																						tt_same[n].mount=dec(tt_same[n].mount)-1;
																					}
																				}
																				//106/09/14 不受項次限制
																				//break;
																			}
																		}
																	}
																	if(t_wlength<0)
																		t_wlength=0;
																	//t_cup[f].wlenhth=t_wlength;
																	t_cup[f].wrate=t_wlength/dec(cupolength);
																	//t_cup[f].cutlength=t_cutlength+'#'+t_wlength;
																	if(t_cup[f].wrate>0){
																		t_cup.splice(f,1)
																		f--;
																	}
																}
															}
															
															//--------------------------------------
															
															//沒有其他組合選自己或更少的數量
															
															//var t_cup=getmlength2(clength,clength,maxcutlengthb,cutlengthbs,'',[],t_same,tspec1,tsize1);
															if(t_cup.length==0 && !t_cupsp){
																rep='';
																//cutlengthbs=$.extend(true,[], b_cutlengthbs);//數量多
																cutlengthbs=cutlengthbs.concat([dec(maxcutlengthb)]);
																cutlengthbs=cutlengthbs.concat(c_cutlengthbs);//數量少
																cutlengthbs=cutlengthbs.concat(d_cutlengthbs);//長度短 且數量少
																
																t_cup=getmlength(clength,clength,maxcutlengthb,cutlengthbs,'',[],t_same,tspec1,tsize1,t_stlen);
															}
															
															//---------------------------------------
															//取得所需數量
															var tt_same=[],tmp_same=[];
															for(var n=0;n<t_same.length;n++){
																var tspec2=t_same[n].spec;
																var tsize2=t_same[n].size;
																var lengthb2=t_same[n].lengthb;
																var tdata2=t_same[n].data;
																if(tspec1==tspec2 && tsize1==tsize2){
																	for(var m=0;m<tdata2.length;m++){
																		if(dec(tdata2[m].mount)>0){
																			tt_same.push({
																				'maxmount':t_same[n].maxmount,
																				'lengthb':lengthb2,
																				'mount':tdata2[m].mount,
																				'nor':tdata2[m].nor,
																				'tw03':tdata2[m].tw03
																			});
																		}
																	}
																}
															}
															tmp_same=$.extend(true,[], tt_same);
															//調整最後剩餘數量是否符合最低損耗率
															for(var f=0;f<t_cup.length;f++){
																tt_same=$.extend(true,[], tmp_same);
																var cupcutlength=t_cup[f].cutlength.split('#')[0].split(',');//切割長度
																var cupcutwlength=dec(t_cup[f].cutlength.split('#')[1]);//損耗長度
																var cupolength=t_cup[f].olength;//裁剪的板料長度
																
																var cuttmp=[];//組合數量
																for (var m=0;m<cupcutlength.length;m++){//裁切數量
																	var x_n=-1;
																	for (var n=0;n<cuttmp.length;n++){
																		if(cuttmp[n].lengthb==dec(cupcutlength[m])){
																			cuttmp[n].mount=cuttmp[n].mount+1;
																			x_n=n;
																			break;	
																		}
																	}
																	if(x_n==-1){
																		cuttmp.push({
																			'lengthb':dec(cupcutlength[m]),
																			'mount':1
																		});
																	}
																}
																var t_wlength=dec(cupolength);
																/*if(t_wlength.toString().slice(-1)=='5'){
																	t_wlength=dec(t_wlength.toString().substr(0,t_wlength.toString().length-1)+'0');
																}*/
																
																var t_cutlength='';
																for (var m=0;m<cuttmp.length;m++){
																	for (var n=0;n<tt_same.length;n++){
																		if(dec(cuttmp[m].mount)>0 && dec(cuttmp[m].lengthb)<=dec(tt_same[n].lengthb) && dec(cuttmp[m].lengthb)>=(dec(tt_same[n].lengthb)-dec(tt_same[n].tw03))){
																			if(dec(cuttmp[m].mount)>dec(tt_same[n].mount)+dec(tt_same[n].maxmount)){
																				t_wlength=q_sub(t_wlength,q_mul(dec(cuttmp[m].lengthb),dec(tt_same[n].mount)+dec(tt_same[n].maxmount)));
																				var ttt_mount=dec(tt_same[n].mount)+dec(tt_same[n].maxmount);
																				while(ttt_mount>0){
																					t_cutlength=t_cutlength+(t_cutlength.length>0?',':'')+cuttmp[m].lengthb;
																					ttt_mount--;
																					cuttmp[m].mount=dec(cuttmp[m].mount)-1;
																					tt_same[n].mount=dec(tt_same[n].mount)-1;
																				}
																			}else{
																				t_wlength=q_sub(t_wlength,q_mul(dec(cuttmp[m].lengthb),cuttmp[m].mount));
																				var ttt_mount=cuttmp[m].mount;
																				while(ttt_mount>0){
																					t_cutlength=t_cutlength+(t_cutlength.length>0?',':'')+cuttmp[m].lengthb;
																					ttt_mount--;
																					cuttmp[m].mount=dec(cuttmp[m].mount)-1;
																					tt_same[n].mount=dec(tt_same[n].mount)-1;
																				}
																			}
																			//106/09/14 不受項次限制
																			//break;
																		}
																	}
																}
																if(t_wlength<0)
																	t_wlength=0;
																t_cup[f].wlenhth=t_wlength;
																t_cup[f].wrate=t_wlength/dec(cupolength);
																t_cup[f].cutlength=t_cutlength+'#'+t_wlength;
																if(t_cup[f].wrate>0){
																	t_cup.splice(f,1);
																	f--;
																}else{
																	//做兩支以上
																	var cuttmp=[];//組合數量
																	for (var m=0;m<cupcutlength.length;m++){//裁切數量
																		var x_n=-1;
																		for (var n=0;n<cuttmp.length;n++){
																			if(cuttmp[n].lengthb==dec(cupcutlength[m])){
																				cuttmp[n].mount=cuttmp[n].mount+1;
																				x_n=n;
																				break;	
																			}
																		}
																		if(x_n==-1){
																			cuttmp.push({
																				'lengthb':dec(cupcutlength[m]),
																				'mount':1
																			});
																		}
																	}
																	var t_wlength=dec(cupolength);
																	/*if(t_wlength.toString().slice(-1)=='5'){
																		t_wlength=dec(t_wlength.toString().substr(0,t_wlength.toString().length-1)+'0');
																	}*/
																	
																	var t_cutlength='';
																	for (var m=0;m<cuttmp.length;m++){
																		for (var n=0;n<tt_same.length;n++){
																			if(dec(cuttmp[m].mount)>0 && dec(cuttmp[m].lengthb)<=dec(tt_same[n].lengthb) && dec(cuttmp[m].lengthb)>=(dec(tt_same[n].lengthb)-dec(tt_same[n].tw03))){
																				if(dec(cuttmp[m].mount)>dec(tt_same[n].mount)+dec(tt_same[n].maxmount)){
																					t_wlength=q_sub(t_wlength,q_mul(dec(cuttmp[m].lengthb),dec(tt_same[n].mount)+dec(tt_same[n].maxmount)));
																					var ttt_mount=dec(tt_same[n].mount)+dec(tt_same[n].maxmount);
																					while(ttt_mount>0){
																						t_cutlength=t_cutlength+(t_cutlength.length>0?',':'')+cuttmp[m].lengthb;
																						ttt_mount--;
																						cuttmp[m].mount=dec(cuttmp[m].mount)-1;
																						tt_same[n].mount=dec(tt_same[n].mount)-1;
																					}
																				}else{
																					t_wlength=q_sub(t_wlength,q_mul(dec(cuttmp[m].lengthb),cuttmp[m].mount));
																					var ttt_mount=cuttmp[m].mount;
																					while(ttt_mount>0){
																						t_cutlength=t_cutlength+(t_cutlength.length>0?',':'')+cuttmp[m].lengthb;
																						ttt_mount--;
																						cuttmp[m].mount=dec(cuttmp[m].mount)-1;
																						tt_same[n].mount=dec(tt_same[n].mount)-1;
																					}
																				}
																				//106/09/14 不受項次限制
																				//break;
																			}
																		}
																	}
																	if(t_wlength<0)
																		t_wlength=0;
																	//t_cup[f].wlenhth=t_wlength;
																	t_cup[f].wrate=t_wlength/dec(cupolength);
																	//t_cup[f].cutlength=t_cutlength+'#'+t_wlength;
																	if(t_cup[f].wrate>0){
																		t_cup.splice(f,1);
																		f--;
																	}
																}
															}
															
															if(t_cup.length==0){
																//cutlengthbs.sort(function(a, b) {if(a>b) {return -1;} if (a < b) {return 1;} return 0;});//長>短
																rep='';
																
																cutlengthbs=[];
																a_cutlengthbs=[];
																b_cutlengthbs=[];
																c_cutlengthbs=[];
																d_cutlengthbs=[];
																e_cutlengthbs=[];
																
																//最短裁剪長度限制
																for(var n=0;n<cutlengthb.length;n++){
																	if(dec(cutlengthb[n])!=dec(maxcutlengthb)){
																		for (var j=0;j<t_same.length;j++){
																			var tspec2=t_same[j].spec;
																			var tsize2=t_same[j].size;
																			var tmount2=t_same[j].mount;
																			var lengthb2=dec(t_same[j].lengthb);
																			if(tspec1==tspec2 && tsize1==tsize2 && dec(cutlengthb[n])==lengthb2 && dec(tmount2)>0){
																				if (t_maxlenmount==dec(t_same[j].mount)){
																					a_cutlengthbs.push(dec(cutlengthb[n]));
																				}else if (t_maxlenmount<dec(t_same[j].mount)){
																					b_cutlengthbs.push(dec(cutlengthb[n]));
																				}else if (t_maxlenmount%dec(t_same[j].mount)){
																					e_cutlengthbs.push(dec(cutlengthb[n]));
																				}else if(dec(t_same[j].mount)==1){
																					d_cutlengthbs.push(dec(cutlengthb[n]));
																				}else{
																					c_cutlengthbs.push(dec(cutlengthb[n]));
																				}
																				
																				break;
																			}
																		}
																	}
																}
																cutlengthbs=$.extend(true,[], [dec(maxcutlengthb)]);
																cutlengthbs=cutlengthbs.concat(a_cutlengthbs);//數量相同
																cutlengthbs=cutlengthbs.concat(b_cutlengthbs);//數量多
																cutlengthbs=cutlengthbs.concat(e_cutlengthbs);//數量少 倍數
																cutlengthbs=cutlengthbs.concat(c_cutlengthbs);//數量少
																cutlengthbs=cutlengthbs.concat(d_cutlengthbs);//數量1
																
																t_cup=getmlength(clength,clength,maxcutlengthb,cutlengthbs,'',[],t_same,tspec1,tsize1,t_stlen);
															}else{
																t_cupsp=true;
															}
															
															t_cup.sort(function(a, b) { if(a.wrate > b.wrate) {return 1;} if (a.wrate < b.wrate) {return -1;}if(a.cutlength.split(',').length>b.cutlength.split(',').length) {return 1;}if(a.cutlength.split(',').length<b.cutlength.split(',').length) {return -1;}return 0;});
															t_cups=t_cups.concat(t_cup);
															
															//106/05/10 取到最無損號就不計算可誤差
															if(t_cup.length>0){
																if(t_cup[0].wlenhth==0){
																	iswlenzero=true;
																	break;
																}													
															}
														}
													}
													if(iswlenzero){break;}
												}
												if(iswlenzero){break;}
											}
										}
									}
								}
							}
							if(bcount==0){
								alert(tspec1+' '+tsize1+'無可使用的板料長度!!');
								break;
							}
							
							//處理最短裁剪長度限制
							if(t_sortlen>0){
								for(var k=0;k<t_cups.length;k++){
									var cupolength=t_cups[k].olength;//裁剪的板料長度
									var cupcutlength=t_cups[k].cutlength.split('#')[0].split(',');//切割長度
									var cupcutlength2=t_cups[k].cutlength.split('#')[0].split(',');//切割長度(無損耗長度)
									var cupcutwlength=dec(t_cups[k].cutlength.split('#')[1]);//損耗長度
									cupcutlength=cupcutlength.concat(cupcutwlength);//加損耗
									var changecup=true;
									for (var m=0;m<cupcutlength.length;m++){
										if(dec(cupcutlength[m])>=t_sortlen){
											changecup=false;
											break;
										}
									}
									if(changecup){ //剪裁長度低於最短裁剪長度
										//拿最小損耗長度當尾刀 加價損失(最小長度限制,已損耗長度,可配對長度,已裁剪長度,暫存裁剪陣列)
										var t_sortcup=getsortlen(dec(t_sortlen),dec(cupcutwlength),cupcutlength2,cupcutwlength,[]);
										t_sortcup.sort(function(a, b) { if(a.wrate > b.wrate) {return 1;} if (a.wrate < b.wrate) {return -1;} return 0;});
										
										if(t_sortcup.length>0){
											var tt_cutlength='';
											var tt_scutlength=t_sortcup[0].cutlength.split(',');
											
											if(dec(cupcutwlength)>0){//原裁剪已有損耗 排除第一筆長度
												tt_scutlength.splice(0, 1);
											}
											//將原裁剪內容變動
											for (var m=0;m<cupcutlength2.length;m++){
												for (var n=0;n<tt_scutlength.length;n++){
													if(cupcutlength2[m]==tt_scutlength[n]){
														cupcutlength2.splice(m, 1);
														m--;
														tt_scutlength.splice(n, 1);
														n--;
													}
												}
											}
											for (var m=0;m<cupcutlength2.length;m++){
												tt_cutlength=tt_cutlength+(tt_cutlength.length>0?',':'')+cupcutlength2[m];
											}
											tt_cutlength=tt_cutlength+'#'+t_sortcup[0].wlength;
											t_cups[k].cutlength=tt_cutlength;
											t_cups[k].wlenhth=t_sortcup[0].wlength;
											t_cups[k].wrate=t_sortcup[0].wlength/t_cups[k].olength;
										}
									}
								}
							}
							
							//取得所需數量
							var tt_same=[],tmp_same=[];
							for(var k=0;k<t_same.length;k++){
								var tspec2=t_same[k].spec;
								var tsize2=t_same[k].size;
								var lengthb2=t_same[k].lengthb;
								var tdata2=t_same[k].data;
								if(tspec1==tspec2 && tsize1==tsize2){
									for(var l=0;l<tdata2.length;l++){
										if(dec(tdata2[l].mount)>0){
											tt_same.push({
												'maxmount':t_same[k].maxmount,
												'lengthb':lengthb2,
												'mount':tdata2[l].mount,
												'nor':tdata2[l].nor,
												'tw03':tdata2[l].tw03
											});
										}
									}
								}
							}
							tmp_same=$.extend(true,[], tt_same);
							//調整最後剩餘數量是否符合最低損耗率
							for(var k=0;k<t_cups.length;k++){
								tt_same=$.extend(true,[], tmp_same);
								var cupcutlength=t_cups[k].cutlength.split('#')[0].split(',');//切割長度
								var cupcutwlength=dec(t_cups[k].cutlength.split('#')[1]);//損耗長度
								var cupolength=t_cups[k].olength;//裁剪的板料長度
								
								var cuttmp=[];//組合數量
								for (var m=0;m<cupcutlength.length;m++){//裁切數量
									var x_n=-1;
									for (var n=0;n<cuttmp.length;n++){
										if(cuttmp[n].lengthb==dec(cupcutlength[m])){
											cuttmp[n].mount=cuttmp[n].mount+1;
											x_n=n;
											break;	
										}
									}
									if(x_n==-1){
										cuttmp.push({
											'lengthb':dec(cupcutlength[m]),
											'mount':1
										});
									}
								}
								var t_wlength=dec(cupolength);
								/*if(t_wlength.toString().slice(-1)=='5'){
									t_wlength=dec(t_wlength.toString().substr(0,t_wlength.toString().length-1)+'0');
								}*/
								
								var t_cutlength='';
								for (var m=0;m<cuttmp.length;m++){
									for (var n=0;n<tt_same.length;n++){
										if(dec(cuttmp[m].mount)>0 && dec(cuttmp[m].lengthb)<=dec(tt_same[n].lengthb) && dec(cuttmp[m].lengthb)>=(dec(tt_same[n].lengthb)-dec(tt_same[n].tw03))){
											if(dec(cuttmp[m].mount)>dec(tt_same[n].mount)+dec(tt_same[n].maxmount)){
												t_wlength=q_sub(t_wlength,q_mul(dec(cuttmp[m].lengthb),dec(tt_same[n].mount)+dec(tt_same[n].maxmount)));
												var ttt_mount=dec(tt_same[n].mount)+dec(tt_same[n].maxmount);
												while(ttt_mount>0){
													t_cutlength=t_cutlength+(t_cutlength.length>0?',':'')+cuttmp[m].lengthb;
													ttt_mount--;
													cuttmp[m].mount=dec(cuttmp[m].mount)-1;
													tt_same[n].mount=dec(tt_same[n].mount)-1;
												}
											}else{
												t_wlength=q_sub(t_wlength,q_mul(dec(cuttmp[m].lengthb),cuttmp[m].mount));
												var ttt_mount=cuttmp[m].mount;
												while(ttt_mount>0){
													t_cutlength=t_cutlength+(t_cutlength.length>0?',':'')+cuttmp[m].lengthb;
													ttt_mount--;
													cuttmp[m].mount=dec(cuttmp[m].mount)-1;
													tt_same[n].mount=dec(tt_same[n].mount)-1;
												}
											}
											//106/09/14 不受項次限制
											//break;
										}
									}
								}
								if(t_wlength<0)
									t_wlength=0;
								t_cups[k].wlenhth=t_wlength;
								t_cups[k].wrate=t_wlength/dec(cupolength);
								t_cups[k].cutlength=t_cutlength+'#'+t_wlength;
								
								//兩支以上
								var cuttmp=[];//組合數量
								for (var m=0;m<cupcutlength.length;m++){//裁切數量
									var x_n=-1;
									for (var n=0;n<cuttmp.length;n++){
										if(cuttmp[n].lengthb==dec(cupcutlength[m])){
											cuttmp[n].mount=cuttmp[n].mount+1;
											x_n=n;
											break;	
										}
									}
									if(x_n==-1){
										cuttmp.push({
											'lengthb':dec(cupcutlength[m]),
											'mount':1
										});
									}
								}
								var t_wlength=dec(cupolength);
								/*if(t_wlength.toString().slice(-1)=='5'){
									t_wlength=dec(t_wlength.toString().substr(0,t_wlength.toString().length-1)+'0');
								}*/
								
								var t_cutlength='';
								for (var m=0;m<cuttmp.length;m++){
									for (var n=0;n<tt_same.length;n++){
										if(dec(cuttmp[m].mount)>0 && dec(cuttmp[m].lengthb)<=dec(tt_same[n].lengthb) && dec(cuttmp[m].lengthb)>=(dec(tt_same[n].lengthb)-dec(tt_same[n].tw03))){
											if(dec(cuttmp[m].mount)>dec(tt_same[n].mount)+dec(tt_same[n].maxmount)){
												t_wlength=q_sub(t_wlength,q_mul(dec(cuttmp[m].lengthb),dec(tt_same[n].mount)+dec(tt_same[n].maxmount)));
												var ttt_mount=dec(tt_same[n].mount)+dec(tt_same[n].maxmount);
												while(ttt_mount>0){
													t_cutlength=t_cutlength+(t_cutlength.length>0?',':'')+cuttmp[m].lengthb;
													ttt_mount--;
													cuttmp[m].mount=dec(cuttmp[m].mount)-1;
													tt_same[n].mount=dec(tt_same[n].mount)-1;
												}
											}else{
												t_wlength=q_sub(t_wlength,q_mul(dec(cuttmp[m].lengthb),cuttmp[m].mount));
												var ttt_mount=cuttmp[m].mount;
												while(ttt_mount>0){
													t_cutlength=t_cutlength+(t_cutlength.length>0?',':'')+cuttmp[m].lengthb;
													ttt_mount--;
													cuttmp[m].mount=dec(cuttmp[m].mount)-1;
													tt_same[n].mount=dec(tt_same[n].mount)-1;
												}
											}
											//106/09/14 不受項次限制
											//break;
										}
									}
								}
								if(t_wlength<0)
									t_wlength=0;
								//t_cups[k].wlenhth=t_wlength;
								if(t_wlength/dec(cupolength)!=t_cups[k].wrate)
									t_cups[k].wrate=1+t_cups[k].wrate;
								//t_cups[k].cutlength=t_cutlength+'#'+t_wlength;
							}
							
							//損耗率排序 低損耗>長板料>裁剪長度>裁剪次數
							//t_cups.sort(function(a, b) { if(a.wrate > b.wrate) {return 1;} if (a.wrate < b.wrate) {return -1;} if(a.olength > b.olength) {return -1;} if (a.olength < b.olength) {return 1;} return 0;});
							
							if(tsize1=='3#' || tsize1=='4#' || tsize1=='5#'){
								//刪除小於最小定尺的損耗組合
								for(var k=0;k<t_cups.length;k++){
									var ttlengthb=dec(t_cups[k].olength.toString().substr(0,t_cups[k].olength.toString().length-2)+'00');
									var t_wlen=t_cups[k].wlenhth;
									if(ttlengthb!=t_cups[k].olength && t_wlen<=(t_cups[k].olength-ttlengthb)){
										t_wlen=0;
									}
									
									if(t_wlen>0 && t_wlen<t_stlen){
										t_cups.splice(k, 1);
                                    	k--;
									}
								}
							}
							
							t_cups.sort(function(a, b) { 
								if(a.wrate > b.wrate) {return 1;} 
								if(a.wrate < b.wrate) {return -1;}
								/*if(lengthmount(a.cutlength,t_same,maxcutlengthbs)>lengthmount(b.cutlength,t_same,maxcutlengthbs)){return -1;}
								if(lengthmount(a.cutlength,t_same,maxcutlengthbs)<lengthmount(b.cutlength,t_same,maxcutlengthbs)){return 1;}*/
								if(dec(a.olength.toString().substr(0,a.olength.toString().length-2)+'00') > dec(b.olength.toString().substr(0,b.olength.toString().length-2)+'00')) {return -1;}
								if(dec(a.olength.toString().substr(0,a.olength.toString().length-2)+'00') < dec(b.olength.toString().substr(0,b.olength.toString().length-2)+'00')) {return 1;}
								if(a.olength > b.olength) {return 1;} 
								if(a.olength < b.olength) {return -1;}
								if(a.cutlength.split(',').length>b.cutlength.split(',').length) {return -1;}
								if(a.cutlength.split(',').length<b.cutlength.split(',').length) {return 1;} 
								if(lengthgroup(a.cutlength)>lengthgroup(b.cutlength)){return -1;}
								if(lengthgroup(a.cutlength)<lengthgroup(b.cutlength)){return 1;}
								return 0;
							});
							
							//取得所需數量
							var tt_same=[];
							for(var k=0;k<t_same.length;k++){
								var tspec2=t_same[k].spec;
								var tsize2=t_same[k].size;
								var lengthb2=t_same[k].lengthb;
								var tdata2=t_same[k].data;
								if(tspec1==tspec2 && tsize1==tsize2){
									for(var l=0;l<tdata2.length;l++){
										if(dec(tdata2[l].mount)>0){
											tt_same.push({
												'maxmount':t_same[k].maxmount,
												'lengthb':lengthb2,
												'mount':tdata2[l].mount,
												'nor':tdata2[l].nor,
												'tw03':tdata2[l].tw03
											});
										}
									}
								}
							}
							
							var tt_zero=false;
							if(tt_same.length>0){//數量大於0才做 越小的長度有可能在之前的裁剪已裁剪出來
								var cuttmp=[];//組合數量
								//找出目前最大長度數量的組合與最小損耗
								var cupcutlength=t_cups[0].cutlength.split('#')[0].split(',');//切割長度
								var cupcutwlength=dec(t_cups[0].cutlength.split('#')[1]);//損耗長度
								var cupolength=t_cups[0].olength;//裁剪的板料長度
								
								var bmount=0;//板料使用數量
								//cupcutlength=cupcutlength.concat(cupcutwlength);//加損耗
								var usemax=0; //使用容許多入數量M09
								while(!tt_zero){ //當最大長度需裁剪量數量<0 或 其他剪裁長度需才剪量<0
									bmount++;
									for (var m=0;m<cupcutlength.length;m++){//裁切數量
										var x_n=-1;
										for (var n=0;n<cuttmp.length;n++){
											if(cuttmp[n].lengthb==dec(cupcutlength[m])){
												cuttmp[n].mount=cuttmp[n].mount+1;
												x_n=n;
												break;	
											}
										}
										if(x_n==-1){
											cuttmp.push({
												'lengthb':dec(cupcutlength[m]),
												'mount':1
											});
										}
										for (var n=0;n<tt_same.length;n++){
											if(dec(cupcutlength[m])<=dec(tt_same[n].lengthb) && dec(cupcutlength[m])>=(dec(tt_same[n].lengthb)-dec(tt_same[n].tw03))
												&& dec(tt_same[n].mount)+dec(tt_same[n].maxmount)>0
											){
												if(dec(tt_same[n].mount)>0)
													tt_same[n].mount=q_sub(tt_same[n].mount,1);
												else
													tt_same[n].maxmount=q_sub(tt_same[n].maxmount,1);
													
												//判斷是否還有其他相同長度
												if(dec(tt_same[n].mount)+dec(tt_same[n].maxmount)<=0){
													var x_nn=-1
													for (var x=0;x<tt_same.length;x++){
														if(dec(cupcutlength[m])<=dec(tt_same[x].lengthb) && dec(cupcutlength[m])>=(dec(tt_same[x].lengthb)-dec(tt_same[x].tw03))
															&& dec(tt_same[x].mount)>0
														){
															x_nn=x;
														}
													}
													if(x_nn==-1){
														tt_zero=true;
													}
												}
												
												//107/02/06 依據台料 判斷是否受項次限制
												/*if(!$('#chkCancel').prop('checked')){
													if(dec(tt_same[n].mount)+dec(tt_same[n].maxmount)<=0){
														tt_zero=true;
													}
													if(dec(tt_same[n].mount)<=0 && dec(tt_same[n].maxmount)>0){
														usemax++;
													}
												}*/
												
												break;
											}
										}
									}
									
									if(usemax>0){
										tt_zero=true;
									}
									
									//檢查下次裁剪是否會多裁剪的數量
									var t_nn=-1;
									if(!tt_zero){
										var ttt_same=$.extend(true,[], tt_same);
										for (var m=0;m<cupcutlength.length;m++){//裁切數量
											var isexist=false;//判斷是否還有被扣料
											for (var n=0;n<ttt_same.length;n++){
												if(dec(cupcutlength[m])<=dec(ttt_same[n].lengthb) && dec(cupcutlength[m])>=(dec(ttt_same[n].lengthb)-dec(ttt_same[n].tw03))
													&& dec(ttt_same[n].mount)+dec(ttt_same[n].maxmount)>0
												){
													if(dec(ttt_same[n].mount)>0){
														ttt_same[n].mount=q_sub(ttt_same[n].mount,1);
														t_nn=n;	
													}else
														ttt_same[n].maxmount=q_sub(ttt_same[n].maxmount,1);
													
													isexist=true;
													
													/*if(dec(ttt_same[n].mount)+dec(ttt_same[n].maxmount)<0){
														tt_zero=true;
													}*/
													break;
												}
											}
											if(!isexist)
												tt_zero=true;
										}
									}
									//判斷是否下次是否可被裁減
									if(t_nn==-1){
										tt_zero=true;
									}
								}
								
								cupcutlength=cupcutlength.concat(cupcutwlength);//加損耗
								
								getucc.push({
									'spec':tspec1,
									'size':tsize1,
									'lengthb':cupolength,
									'wlengthb':cupcutwlength,
									'mount':bmount,
									'usemaxmount':usemax,
									'nor':'',
									'cutlen':cupcutlength,
									'data':cuttmp,
									'typea':'b'
								});
							}
							
							var t_nor='';
							var t_noras=[];
							//扣除已裁切完的數量
							cuttmp.sort(function(a, b) { if(dec(a.lengthb) > dec(b.lengthb)) {return 1;} if (dec(a.lengthb) < dec(b.lengthb)) {return -1;} return 0;})
							for (var m=0;m<cuttmp.length;m++){
								for(var k=0;k<t_same.length;k++){
									var tspec2=t_same[k].spec;
									var tsize2=t_same[k].size;
									var lengthb2=t_same[k].lengthb;
									var tdata2=t_same[k].data;
									var texists2=false;
									for (var x=0;x<tdata2.length;x++){
										if(tspec1==tspec2 && tsize1==tsize2 && dec(tdata2[x].mount)>0 && dec(cuttmp[m].mount)>0 
											&& dec(cuttmp[m].lengthb)<=dec(lengthb2) && dec(cuttmp[m].lengthb)>=(dec(lengthb2)-dec(tdata2[x].tw03))
										){
											var tcutmount=0;
											if(t_same[k].data[x].mount>=cuttmp[m].mount){
												tcutmount=cuttmp[m].mount;
												t_same[k].mount=t_same[k].mount-cuttmp[m].mount;
												t_same[k].data[x].mount=t_same[k].data[x].mount-cuttmp[m].mount;
												cuttmp[m].mount=0;
											}else{
												tcutmount=t_same[k].data[x].mount;
												t_same[k].mount=t_same[k].mount-t_same[k].data[x].mount;
												cuttmp[m].mount=cuttmp[m].mount-t_same[k].data[x].mount;
												t_same[k].data[x].mount=0;
											}
											
											if(t_same[k].data[x].mount<0 && t_same[k].maxmount>0){
												t_same[k].maxmount=t_same[k].maxmount+t_same[k].data[x].mount;
											}
											if(t_same[k].maxmount<0){
												t_same[k].maxmount=0;
											}
											
											var tt_nor=t_nor.split(',');
											var tt_norexist=false;
											for(var o=0;o<tt_nor.length;o++){
												if(tt_nor[o]==(t_same[k].data[x].nor+1).toString()){
													tt_norexist=true;
													break;
												}
											}
											if(!tt_norexist){
												t_nor=t_nor+(t_nor.length>0?',':'')+(t_same[k].data[x].nor+1);
											}
											//106/09/14-------------------------------
											tt_norexist=false;
											for(var o=0;o<t_noras.length;o++){
												if(t_noras[o].nor==(t_same[k].data[x].nor+1).toString()){
													t_noras[o].mount=q_add(t_noras[o].mount,tcutmount);
													tt_norexist=true;
													break;
												}
											}
											if(!tt_norexist){
												t_noras.push({
													nor:(t_same[k].data[x].nor+1).toString(),
													mount:tcutmount
												});
											}
											//-----------------------------
											//106/09/14 不受項次限制
											//texists2=true;
											//break;
											if(cuttmp[m].mount<=0){
												texists2=true;
												break;
											}
										}
									}
									if(texists2){
										break;
									}
								}
							}
							//更新最後一個物料的配料項次
							if(getucc.length>0){
								if(getucc[getucc.length-1].nor=='')
									getucc[getucc.length-1].nor=t_nor;
								getucc[getucc.length-1].noras=t_noras;
							}
							
							//已裁剪完的長度已不需要
							//cutlengthb.splice(j, 1);
							//j--;
							//其他剪長的長度也刪除
							for(var m=0;m<cutlengthb.length;m++){
								for(var k=0;k<t_same.length;k++){
									var tspec2=t_same[k].spec;
									var tsize2=t_same[k].size;
									var lengthb2=t_same[k].lengthb;
									var mount2=t_same[k].mount;
									if(tspec1==tspec2 && tsize1==tsize2 && cutlengthb[m]==lengthb2 && mount2<=0){
										cutlengthb.splice(m, 1);
										m--;
									}
								}	
							}
						
							//重新排序--------------------------------------------------
							//讀取相同材質號數的長度
							cutlengthb=[];
							for (var j=0;j<t_same.length;j++){
								var tspec2=t_same[j].spec;
								var tsize2=t_same[j].size;
								var tmount2=t_same[j].mount;
								var lengthb2=dec(t_same[j].lengthb);
								if(tspec1==tspec2 && tsize1==tsize2 && dec(tmount2)>0){
									cutlengthb.push(lengthb2);
								}
							}
							
							//裁剪長度排序(最短,...,最長)
							cutlengthb.sort(function(a, b) {if(a>b) {return 1;} if (a < b) {return -1;} return 0;});
							maxcutlengthb=cutlengthb[cutlengthb.length-1];
							//107/01/30 可直接整除的長度先不選擇
							for(var m=cutlengthb.length-1;m>0;m--){
								var t_ismod=false;
								for(var k=0;k<t_cutsheet.length;k++){
									var clength=(dec(t_cutsheet[k])*100);
									if(clength%dec(maxcutlengthb)==0){
										if(m>0)
											maxcutlengthb=cutlengthb[m-1];
										t_ismod=true;
										break;
									}
								}
								if(!t_ismod){
									break;
								}
							}
						}
					}
				}
				
				t_p3getucc=$.extend(true,[], getucc);
				return;

			}
			
			function getmlength2 (olength,lengthb,cut,cutlength,cutall,cutarry,t_same,tspec1,tsize1){
				//原長度,目前長度,本次裁剪長度,可裁剪長度,裁剪樣式,回傳陣列
				if(rep.indexOf("@@")>-1){ //已找到損耗0的組合後續不再處理
					return cutarry;
				}
				
				//可繼續裁剪
				if(cut>=0 && lengthb-cut>=0){
					lengthb=lengthb-cut;
					if(cut>0)
						cutall=cutall+(cutall.length>0? ',':'')+cut;
					
					var twrate=dec($('#txtMo').val())/100;
					var twlength=dec($('#txtWaste').val());
					
					//損耗0的組合
					if(lengthb==0){
						cutarry.push({'olength':olength,'cutlength':cutall,'wlenhth':lengthb,'wrate':round(lengthb/olength,4)});
						//if(cutlength.length>25 || cutarry.length>2000) //仍要抓避免 無法 調整最後剩餘數量的最低損耗率
							rep='@@';
						return cutarry;
					}else{//繼續裁剪
						var nn=0;
						var tttcutlength=$.extend(true,[], cutlength);
						tttcutlength.splice(0,1);
						for(var i=0;i<cutlength.length;i++){
							if(lengthb-cutlength[i]>=0){
								getmlength2(olength,lengthb,cutlength[i],tttcutlength,cutall,cutarry,t_same,tspec1,tsize1);
								nn++;
							}
						}
						
						if(nn==0){//無法再裁剪>損耗
							cutall=cutall+'#'+lengthb;
							if(lengthb==0)
								cutarry.push({'olength':olength,'cutlength':cutall,'wlenhth':lengthb,'wrate':round(lengthb/olength,4)});
							return cutarry;
						}
					}
				}else{//無法再裁剪>損耗
					cutall=cutall+'#'+lengthb;
					if(lengthb==0)
						cutarry.push({'olength':olength,'cutlength':cutall,'wlenhth':lengthb,'wrate':round(lengthb/olength,4)});
					return cutarry;
				}
				return cutarry;
			}
			
		</script>
		<style type="text/css">
			#dmain {
				/*overflow: hidden;*/
			}
			.dview {
				float: left;
				border-width: 0px;
			}
			.tview {
				border: 5px solid gray;
				font-size: medium;
				background-color: black;
			}
			.tview tr {
				height: 30px;
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
				width: 980px;
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
				/*width: 9%;*/
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
				color: black;
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
			.num {
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
			.tbbm .cut{
				background: antiquewhite;
			}
			input[type="text"], input[type="button"] ,select{
				font-size: medium;
			}
			.dbbs {
				width: 1800px;
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
				width: 100%;
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
				width: 1600px;
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
			#q_acDiv {
				white-space: nowrap;
			}
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<!--#include file="../inc/toolbar.inc"-->
		<div id="div_cutmerge" style="position:absolute; top:300px; left:400px; display:none; width:800px; background-color: #CDFFCE; border: 5px solid gray;"> </div>
		<div id="div_addcut" style="position:absolute; top:300px; left:400px; display:none; width:200px; background-color: #CDFFCE; border: 5px solid gray;"> </div>
		<div id='dmain' style="width: 1800px;">
			<div class="dview" id="dview" >
				<table class="tview" id="tview" >
					<tr>
						<td style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td style="width:120px; color:black;"><a id='vewNoa'> </a></td>
						<td style="width:90px; color:black;"><a id='vewDatea'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td id='noa' style="text-align: center;">~noa</td>
						<td id='datea' style="text-align: center;">~datea</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm" id="tbbm">
					<tr style="height:1px;">
						<td width="105px;"> </td>
						<td width="105px;"> </td>
						<td width="105px;"> </td>
						<td width="105px;"> </td>
						<td width="20px;"> </td>
						<td width="125px;"> </td>
						<td width="70px;"> </td>
						<td width="125px;"> </td>
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td><input id="txtDatea" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td><input id="txtNoa" type="text" class="txt c1"/></td>
						<td> </td>
						<td class="cut">整料+算料+卸料</td>
						<td class="cut"><input id="txtM2" type="text" class="txt num c1" /></td>
						<td class="cut">秒/板料</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMech" class="lbl" > </a></td>
						<td><select id="cmbMechno" style="font-size: medium"> </select></td>
						<td><span> </span><a id="lblWorkjno" class="lbl"> </a></td>
						<td><input id="txtMemo2" type="text" class="txt c1"/></td>
						<td> </td>
						<td class="cut">撞齊/刀</td>
						<td class="cut"><input id="txtM3" type="text" class="txt num c1" /></td>
						<td class="cut">秒</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblBdate" class="lbl" > </a></td>
						<td colspan="2">
							<input id="txtBdate" type="text" style="width:43%;"/>
							<span style="float:left; display:block; width:20px;"><a> ～ </a></span>
							<input id="txtEdate" type="text" style="width:43%;"/>
						</td>
						<td><input type="button" id="btnWorkjImport" style="width:120px;text-align: left;"/></td>
						<td> </td>
						<td class="cut">送料/刀</td>
						<td class="cut"> </td>
						<td class="cut"> </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblSpec" class="lbl" > </a></td>
						<td  rowspan='2'><select id="cmbSpec" class="txt c1"  multiple="multiple" size="3"> </select></td>
						<td>
							<a id="lblM1" class="lbl" style="float: left;"> </a><span style="float: left;"> </span>
							<select id="cmbM1" class="txt c1" style="width: 70px;"> </select>
						</td>
						<td> </td>
						<td> </td>
						<td class="cut"><a style="margin-left: 50px;">1.5M內</a></td>
						<td class="cut"><input id="txtM4" type="text" class="txt num c1" style="width: 70%;"/>秒</td>
						<td class="cut"> </td>
					</tr>
					<tr>
						<td> </td>
						<td><span> </span><a class="lbl" >板料可延長長度</a></td>
						<td><input id="txtLevel" type="text" class="txt num c1" style="width:20px;" /><a style="margin-left: 5px;">cm</a></td>
						<td> </td>
						<td class="cut"><a style="margin-left: 50px;">1.5~4M</a></td>
						<td class="cut"><input id="txtM5" type="text" class="txt num c1" style="width: 70%;"/>秒</td>
						<td class="cut"> </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblStatus" class="lbl" > </a></td>
						<td colspan="2" rowspan='4'>
							<input id="txtStatus" type="hidden" class="txt c1"/>
							<select id="combStatus" class="txt c1" multiple="multiple" size="5"> </select>
						</td>
						<td><select id="cmbProcess" class="txt c1" > </select></td>
						<td> </td>
						<td class="cut"><a style="margin-left: 50px;">4M~7M</a></td>
						<td class="cut"><input id="txtM6" type="text" class="txt num c1" style="width: 70%;"/>秒</td>
						<td class="cut"> </td>
					</tr>
					<tr>
						<td> </td>
						<td><input type="button" id="btnUcccstk" style="width:120px;text-align: left;" /></td>
						<td> </td>
						<td class="cut"><a style="margin-left: 50px;">7M以上</a></td>
						<td class="cut"><input id="txtM7" type="text" class="txt num c1" style="width: 70%;"/>秒</td>
						<td class="cut"> </td>
					</tr>
					<tr>
						<td> </td>
						<td style="color: red;">多選請按Ctrl點選</td>
						<td> </td>
						<td class="cut">裁剪</td>
						<td class="cut"><input id="txtM8" type="text" class="txt num c1" /></td>
						<td class="cut">秒/刀 </td>
					</tr>
					<tr>
						<td> </td>
						<td> </td>
						<td> </td>
						<td class="cut">卸料/刀</td>
						<td class="cut"> </td>
						<td class="cut"> </td>
					</tr>
					<tr>
						<!--<td>
							<span> </span><a id="lblStoreno" class="lbl" > </a>
							<input id="chkNotv" type="checkbox" style="float: right;"/>
						</td>
						<td><input id="txtTggno" type="text" class="txt c1"/></td>
						<td><input id="txtTgg" type="text" class="txt c1"/></td>
						<td> </td>-->
						<td><span> </span><a id="lblWaste" class="lbl" > </a></td>
						<td><input id="txtWaste" type="text" class="txt num c1"/></td>
						<td>
							<span style="float: left;margin-left: 3px;display: none;"> </span><a id="lblCancel_fe" class="lbl" style="float: left;display: none;">台料</a>
							<input id="chkCancel" type="checkbox" style="display: none;">
						</td>
						<td><input type="button" id="btnCubu" style="width:120px;text-align: left;"/></td>
						<td> </td>
						<td class="cut"><a style="margin-left: 50px;">1.5M內</a></td>
						<td class="cut"><input id="txtBdime" type="text" class="txt num c1" style="width: 70%;" />秒</td>
						<td class="cut"> </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMo" class="lbl" > </a></td>
						<td><input id="txtMo" type="text" class="txt num c1"/></td>
						<td><span> </span><a id="lblM9" class="lbl" >可容許多出貨%</a></td>
						<td><input id="txtM9" type="text" class="txt num c1"/></td>
						<td> </td>
						<td class="cut"><a style="margin-left: 50px;">1.5~8M</a></td>
						<td class="cut"><input id="txtEdime" type="text" class="txt num c1" style="width: 70%;"/>秒</td>
						<td class="cut"> </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblC1" class="lbl" > </a></td>
						<td><input id="txtC1" type="text" class="txt num c1"/></td>
						<td><span> </span><a id="lblIdime_fe" class="lbl" >使用安全庫存%</a> </td>
						<td><input id="txtIdime" type="text" class="txt num c1"/></td>
						<td> </td>
						<td class="cut"><a style="margin-left: 50px;">8~16M</a></td>
						<td class="cut"><input id="txtOdime" type="text" class="txt num c1" style="width: 70%;"/>秒</td>
						<td class="cut"> </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl" > </a></td>
						<td colspan="3"><input id="txtMemo" type="text" class="txt c1"/></td>
						<td> </td>
						<td class="cut"> </td>
						<td class="cut"><input type="button" id="btnStk" style="width:120px;"/></td>
						<td class="cut"> </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWorker" class="lbl" > </a></td>
						<td><input id="txtWorker" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblWorker2" class="lbl" > </a></td>
						<td><input id="txtWorker2" type="text" class="txt c1"/></td>
						<td> </td>
						<td class="cut"> </td>
						<td class="cut"><input id="btnSafefe" type="button" value="低於安全存量" style="display: none;" ></td>
						<td class="cut"> </td>
					</tr>
				</table>
			</div>
			<div id="dstksafe" style="float: left;display: none;">
				<table id="tstksafe" border="1" style="background: aliceblue;text-align: center;">
				</table>
			</div>
			<div class='dbbs'>
				<table id="tbbs" class='tbbs'>
					<tr style='color:white; background:#003366;' >
						<td style="width:20px;">
							<input id="btnPlus" type="button" style="font-size: medium; font-weight: bold;" value="＋"/>
						</td>
						<td style="width:20px;"> </td>
						<td style="width:150px;"><a id='lblCustno_s'> </a></td>
						<td style="width:120px;"><a id='lblProductno_s'> </a></td>
						<td style="width:200px;"><a id='lblProduct_s'> </a></td>
						<td style="width:100px;"><a id='lblScolor_s'> </a></td>
						<!--<td style="width:40px;"><a id='lblUnit_s'> </a></td>
						<td style="width:100px;"><a id='lblSpec_s'> </a></td>
						<td style="width:80px;"><a id='lblSize_s'> </a></td>-->
						<!--<td style="width:60px;"><a id='lblClass'> </a></td>-->
						<td style="width:80px;"><a id='lblLengthb_s'> </a></td>
						<td style="width:80px;"><a id='lblMount_s'> </a></td>
						<td style="width:100px;"><a id='lblWeight_s'> </a></td>
						<!--<td style="width:80px;"><a id='lblW05_s'> </a></td>
						<td style="width:80px;"><a id='lblW06_s'> </a></td>
						<td style="width:100px;"><a id='lblW07_s'> </a></td>-->
						<td style="width:170px;"><a id='lblW01_s'> </a></td>
						<td style="width:100px;"><a id='lblW03_s'> </a></td>
						<!--<td style="width:100px;"><a id='lblW04_s'> </a></td>-->
						<!--<td style="width:150px;"><a id='lblNeed_s'> </a></td>-->
						<td><a id='lblMemo_s'> </a></td>
						<td style="width:90px;"><a id='lblDate2_s'> </a></td>
						<td style="width:30px;"><a id='lblEnda_s'> </a></td>
						<td style="width:30px;"><a id='lblSale_s'> </a></td>
						<td style="width:150px;"><a id='lblMech_s'> </a></td>
						<td style="width:120px;"><a id='lblOrdeno_s'> </a></td>
						<td style="width:50px;"><a id='lblNo2_s'> </a></td>
						<!--<td style="width:100px;"><a id='lblPrice_s'> </a></td>-->
						<!--<td style="width:100px;"><a id='lblDatea_s'> </a></td>-->
					</tr>
					<tr style='background:#cad3ff;'>
						<td align="center">
							<input id="btnMinus.*" type="button" style="font-size: medium; font-weight: bold;" value="－"/>
							<input id="txtNoq.*" type="text" style="display: none;"/>
						</td>
						<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
						<td>
							<input id="txtCustno.*" type="text" class="txt c1" style="display:none;"/>
							<input id="txtComp.*" type="text" class="txt c1"/>
						</td>
						<td><input id="txtProductno.*" type="text" class="txt c1"/></td>
						<td><input id="txtProduct.*" type="text" class="txt c1"/></td>
						<td><input id="txtScolor.*" type="text" class="txt c1"/></td>
						<!--<td><input id="txtUnit.*" type="text" class="txt c1"/></td>
						<td><input id="txtSpec.*" type="text" class="txt c1"/></td>
						<td><input id="txtSize.*" type="text" class="txt c1"/></td>-->
						<!--<td><input id="txtClass.*" type="text" class="txt c1"/></td>-->
						<td><input id="txtLengthb.*" type="text" class="txt c1 num"/></td>
						<td><input id="txtMount.*" type="text" class="txt c1 num"/></td>
						<td><input id="txtWeight.*" type="text" class="txt c1 num"/></td>
						<!--<td><input id="txtW05.*" type="text" class="txt c1 num"/></td>
						<td><input id="txtW06.*" type="text" class="txt c1 num"/></td>
						<td><input id="txtW07.*" type="text" class="txt c1 num"/></td>-->
						<td>
							<input id="txtW01.*" type="text" class="txt c1 num" style="width: 43%;"/>
							<a style="float: left;">~</a>
							<input id="txtW02.*" type="text" class="txt c1 num" style="width: 43%;"/>
						</td>
						<td><input id="txtW03.*" type="text" class="txt c1 num"/></td>
						<!--<td><input id="txtW04.*" type="text" class="txt c1 num"/></td>-->
						<!--<td><input id="txtNeed.*" type="text" class="txt c1"/></td>-->
						<td><input id="txtMemo.*" type="text" class="txt c1"/></td>
						<td><input id="txtDate2.*" type="text" class="txt c1"/></td>
						<td><input id="chkEnda.*" type="checkbox"/></td>
						<td><input id="chkSale.*" type="checkbox"/></td>
						<td>
							<input id="txtProcessno.*" type="text" class="txt c1" style="width: 30%;"/>
							<input id="txtProcess.*" type="text" class="txt c1"  style="width: 60%;"/>
						</td>
						<td><input id="txtOrdeno.*" type="text" class="txt c1"/></td>
						<td><input id="txtNo2.*" type="text" class="txt c1"/></td>
						<!--<td><input id="txtPrice.*" type="text" class="txt c1 num"/></td>
						<td><input id="txtDatea.*" type="text" class="txt c1"/></td>-->
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
		<div id="dbbt" class='dbbt'>
			<table id="tbbt" class="tbbt">
				<tr class="head" style="color:white; background:#003366;">
					<td style="width:20px;">
						<input id="btnPlut" type="button" style="font-size: medium; font-weight: bold;" value="＋"/>
					</td>
					<td style="width:20px;"> </td>
					<td style="width:150px; text-align: center;"><a id='lblUno_t'> </a></td>
					<td style="width:120px; text-align: center;"><a id='lblProductno_t'> </a></td>
					<td style="width:200px; text-align: center;"><a id='lblProduct_t'> </a></td>
					<td style="width:40px; text-align: center;"><a id='lblUnit_t'> </a></td>
					<!--<td style="width:100px; text-align: center;"><a id='lblSpec_t'> </a></td>
					<td style="width:80px; text-align: center;"><a id='lblSize_t'> </a></td>
					<td style="width:80px; text-align: center;"><a id='lblLengthb_t'> </a></td>-->
					<td style="width:80px; text-align: center;"><a id='lblGmount_t'> </a></td>
					<td style="width:100px; text-align: center;"><a id='lblGweight_t'> </a></td>
					<td style="width:150px; text-align: center;"><a id='lblStore_t'> </a></td>
					<td style="width:80px; text-align: center;"><a id='lblNor_t'> </a></td>
					<td style="text-align: center;"><a id='lblMemo_t'> </a></td>
					<td style="width:300px;text-align: center;">
						<a id='lblMemo2_t'> </a><BR>
						<input id='btnCutmerge' type="button" value="合併裁減內容" style="display: none;">
						<input id='btnAddcut' type="button" value="多配長度支數" style="display: none;">
					</td>
					<td style="width:100px;text-align: center;"><a id='lblLengthc_t'> </a></td>
					<!--<td style="width:200px;text-align: center;"><a id='lblScolor_t'> </a></td>
					<td style="width:100px;text-align: center;"><a id='lblHard_t'> </a></td>-->
				</tr>
				<tr>
					<td>
						<input id="btnMinut..*" type="button" style="font-size: medium; font-weight: bold;" value="－"/>
						<input class="txt" id="txtNoq..*" type="text" style="display: none;"/>
					</td>
					<td><a id="lblNo..*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td><input id="txtUno..*" type="text" class="txt c1"/></td>
					<td><input id="txtProductno..*" type="text" class="txt c1"/></td>
					<td><input id="txtProduct..*" type="text" class="txt c1"/></td>
					<td><input id="txtUnit..*" type="text" class="txt c1"/></td>
					<!--<td><input id="txtSpec..*" type="text" class="txt c1"/></td>
					<td><input id="txtSize..*" type="text" class="txt c1"/></td>
					<td><input id="txtLengthb..*" type="text" class="txt c1 num"/></td>-->
					<td><input id="txtGmount..*" type="text" class="txt c1 num"/></td>
					<td><input id="txtGweight..*" type="text" class="txt c1 num"/></td>
					<td>
						<input id="txtStoreno..*" type="text" class="txt c1" style="width: 30%;"/>
						<input id="txtStore..*" type="text" class="txt c1"  style="width: 60%;"/>
					</td>
					<td><input id="txtNor..*" type="text" class="txt c1"/></td>
					<td><!--<input id="txtMemo..*" type="text" class="txt c1"/>-->
						<textarea id="txtMemo..*" rows='5' cols='10' style="width:99%; height: 50px;"> </textarea>
					</td>
					<td><input id="txtMemo2..*" type="text" class="txt c1"/></td>
					<td><input id="txtLengthc..*" type="text" class="txt c1 num"/></td>
					<!--<td><input id="txtScolor..*" type="text" class="txt c1"/></td>
					<td><input id="txtHard..*" type="text" class="txt c1 num"/></td>-->
				</tr>
			</table>
		</div>
	</body>
</html>