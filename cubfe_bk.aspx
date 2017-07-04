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
			var q_readonly = ['txtNoa','txtC1','textStksafe'];
			var q_readonlys = ['txtDate2', 'txtOrdeno', 'txtNo2','txtProduct','txtScolor','txtLengthb','txtMount','txtWeight','txtProcess'];
			var q_readonlyt = [];
			var bbmNum = [['txtM2',10,0,1],['txtM3',10,0,1],['txtM4',10,0,1],['txtM5',10,0,1],['txtM6',10,0,1],['txtM7',10,0,1],['txtM8',10,0,1]
			,['txtBdime',10,0,1],['txtEdime',10,0,1],['txtOdime',10,0,1],['txtC1',15,0,1]];
			var bbsNum = [['txtMount',10,0,1],['txtWeight',10,2,1],['txtW01',10,2,1],['txtW02',10,2,1],['txtW03',10,2,1],['txtW04',10,2,1]];
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
				var t_c1=0
				for (var j = 0; j < q_bbtCount; j++) {
					var t_lengthc = dec($('#txtLengthc__' + j).val());
					var t_gmount = dec($('#txtGmount__' + j).val());
					var t_hard= dec($('#txtHard__' + j).val());
					t_c1=q_add(t_c1,q_sub(q_mul(t_lengthc,t_gmount),t_hard));
				}
				
				$('#txtC1').val(t_c1);
			}

			function mainPost() {
				q_getFormat();
				bbmMask = [['txtDatea', r_picd], ['txtBdate', r_picd], ['txtEdate', r_picd]];
				bbsMask = [['txtDate2', r_picd], ['txtDatea', r_picd]];
				q_mask(bbmMask);
				q_cmbParse("cmbMechno", "01@剪台,02@火切");
				
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
				q_cmbParse("cmbStatus", t_item);
				
				$('#btnStk').click(function() {
					q_box("z_uccfe.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";", 'z_uccfe', "95%", "95%", $('#btnStk').val());
				});
				
				$('#btnWorkjImport').click(function() {
					var t_mech=$('#cmbMechno').val();
					var t_bdate = trim($('#txtBdate').val());
					var t_edate = trim($('#txtEdate').val());
					var t_spec = trim($('#cmbSpec').val());
					var t_m1 = trim($('#cmbM1').val());
					//外調定尺不用裁剪
					//var t_where = " 1=1 and (mech1='"+t_mech+"' or mech2='"+t_mech+"' or mech3='"+t_mech+"' or mech4='"+t_mech+"' or mech5='"+t_mech+"')";
					var t_where = " 1=1";
					t_bdate = (emp(t_bdate) ? '' : t_bdate);
					t_edate = (emp(t_edate) ? r_picd : t_edate);
					t_where += " and (a.odate between '" + t_bdate + "' and '" + t_edate + "') ";
					if(t_spec.length>0){
						t_where += " and (b.product like '%" + t_spec + "%') ";
					}
					if(t_m1.length>0){
						t_where += " and (b.product like '%" + t_m1 + "%') ";
					}
					
					if(q_cur==1 || q_cur==2)
						q_box("workjsfe_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'workjsfe_b', "95%", "95%", q_getMsg('popOrde'));
				});
				
				$('#btnCubu').click(function() {
					if (q_cur == 0 || q_cur==4) {
						var t_where = "noa='" + trim($('#txtNoa').val()) + "'";
						q_box("cubufe_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where + ";"+r_accy, 'cubu', "95%", "95%", q_getMsg('popCubu'));
					}
				});
				
				$('#btnUcccstk').click(function() {
					//return;
					Lock();
					var t_err='';
					var t_same=[];
					//相同材質號數長度合併
					for (var i = 0; i < q_bbsCount; i++) {
						if(!emp($('#txtProductno_'+i).val()) && !emp($('#txtProduct_'+i).val()) && $('#txtProduct_'+i).val().indexOf('鋼筋')>-1){
							var tproduct=$('#txtProduct_'+i).val();
							var tmount=dec($('#txtW07_'+i).val());//dec($('#txtMount_'+i).val());//裁剪數量
							//材質號數長度
							var tspec=tproduct.substr(tproduct.indexOf('S'),tproduct.indexOf(' ')-tproduct.indexOf('S'))
							var tsize=tproduct.split(' ')[1].split('*')[0];
							var tlength=dec($('#txtLengthb_'+i).val());
							var tw03=dec($('#txtW03_'+i).val()); //容許損耗長度
							var tw04=dec($('#txtW04_'+i).val()); //容許損耗%
							
							var t_j=-1;
							for (var j=0;j<t_same.length;j++){
								if(t_same[j].spec==tspec && t_same[j].size==tsize && t_same[j].lengthb==tlength){
									t_j=j;
									t_same[j].data.push({
										'nor':i,
										'mount':tmount,
										'w03':tw03,
										'w04':tw04
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
										'w03':tw03,
										'w04':tw04
									}]
								});
							}
						}
					}
					
					var getucc=[];
					var t_cutlength=$('#cmbStatus').val();//可裁剪的板料長度
					if(t_cutlength.length==0){
						t_cutlength='12';
						t_cutlength=t_cutlength.split(',');
					}
					
					//推算選料
					//先裁剪最大長度
					t_same.sort(function(a, b) {if(a.lengthb>b.lengthb) {return -1;} if (a.lengthb < b.lengthb) {return 1;} return 0;});
					
					var specsize='';
					for (var i=0;i<t_same.length;i++){
						var blength=''; //版料可用長度
						//材質號數
						var tspec1=t_same[i].spec;
						var tsize1=t_same[i].size;
						//取得設定可使用的板料長度
						q_gt('add5', "where=^^typea='"+tsize1+"'^^" , 0, 0, 0, "getadd5",r_accy,1); //號數
						var as = _q_appendData("add5s", "", true);
						for (var j=0;j<as.length;j++){
							blength=blength+as[j].postno+',';
						}
						
						if(specsize.indexOf(tspec1+tsize1+'#')==-1){//已做過的相同材質號數 不在做一次
							specsize=specsize+tspec1+tsize1+'#';
							var cutlengthb='';
							//相同材質號數的長度
							for (var j=0;j<t_same.length;j++){
								var tspec2=t_same[j].spec;
								var tsize2=t_same[j].size;
								var lengthb2=t_same[j].lengthb;
								if(tspec1==tspec2 && tsize1==tsize2){
									cutlengthb=cutlengthb+(cutlengthb.length>0?',':'')+lengthb2;
								}
							}
							cutlengthb=cutlengthb.split(',');//要裁剪的長度
							for(var j=0;j<cutlengthb.length;j++){
								cutlengthb[j]=dec(cutlengthb[j]);
							}
							cutlengthb.sort(function(a, b) { if(a > b) {return -1;} if (a < b) {return 1;} return 0;});
							
							if(cutlengthb.length>20){
								if(!confirm('裁剪'+tspec1+' '+tsize1 +'的長度超過20組，電腦配料會花費較長時間配對，請確認是否繼續?')){
									break;
								}
							}
							
							//取得裁切組合
							var t_cups=[];
							/*for(var j=0;j<t_cutlength.length;j++){
								var clength=dec(t_cutlength[j])*100; //原單位M
								var t_cup=getmlength(clength,clength,0,cutlengthb,'',[]);
								t_cups=t_cups.concat(t_cup);
							}
							
							//損耗率排序
							t_cups.sort(function(a, b) { if(a.wrate > b.wrate) {return 1;} if (a.wrate < b.wrate) {return -1;} return 0;});*/
							
							//材質號數最大長度 先處理
							for(var j=0;j<cutlengthb.length;j++){//已排序過 由大到小
								//取得所需數量
								var max_mount=0;
								var t_nor='';
								var t_n=-1;
								
								//已裁剪完的長度已不需要，再重新取得組合 求得最小損耗
								t_cups=[];
								var bcount=0;
								for(var k=0;k<t_cutlength.length;k++){
									var clength=dec(t_cutlength[k])*100; //原單位M
									rep='';
									if(blength.indexOf(t_cutlength[k])>-1){
										bcount++;
										var t_cup=getmlength(clength,clength,cutlengthb[j],cutlengthb,'',[],0);
										t_cups=t_cups.concat(t_cup);
									}
								}
								if(bcount==0){
									alert(tspec1+' '+tsize1+'無可使用的板料長度!!');
									break;
								}
								
								//損耗率排序
								t_cups.sort(function(a, b) { if(a.wrate > b.wrate) {return 1;} if (a.wrate < b.wrate) {return -1;} return 0;});
								
								for(var k=0;k<t_same.length;k++){
									var tspec2=t_same[k].spec;
									var tsize2=t_same[k].size;
									var lengthb2=t_same[k].lengthb;
									if(tspec1==tspec2 && tsize1==tsize2 && cutlengthb[j]==lengthb2){
										t_n=k;
										break;
									}
								}
								max_mount=t_same[t_n].mount;
								if(max_mount>0){//數量大於0才做 越小的長度有可能在之前的裁剪已裁剪出來
									var cuttmp=[];//組合數量
									//找出目前最大長度數量的組合與最小損耗
									for(var k=0;k<t_cups.length;k++){//最小損耗排序
										var cupcutlength=t_cups[k].cutlength.split('#')[0].split(',');//切割長度
										var cupcutwlength=t_cups[k].cutlength.split('#')[1];//損耗長度
										var cupolength=t_cups[k].olength;//裁剪的板料長度
										
										if(cutlengthb[j]==dec(cupcutlength[0])){//取得第一個組合
											var bmount=0;//板料使用數量
											cupcutlength=cupcutlength.concat(cupcutwlength);//加損耗
											while(max_mount>0){
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
													if(dec(cupcutlength[m])==cutlengthb[j]){
														max_mount--;
													}
												}
											}
											getucc.push({
												'spec':tspec1,
												'size':tsize1,
												'lengthb':cupolength,
												'wlengthb':cupcutwlength,
												'mount':bmount,
												'nor':'',
												'cutlen':cupcutlength,
												'data':cuttmp
											});
											break;
										}
									}
								}
								//扣除已裁切完的數量
								for (var m=0;m<cuttmp.length;m++){
									for(var k=0;k<t_same.length;k++){
										var tspec2=t_same[k].spec;
										var tsize2=t_same[k].size;
										var lengthb2=t_same[k].lengthb;
										if(tspec1==tspec2 && tsize1==tsize2 && lengthb2==cuttmp[m].lengthb){
											t_same[k].mount=t_same[k].mount-cuttmp[m].mount;
											var tcusttmpmount=cuttmp[m].mount;
											
											for(var n=0;n<t_same[k].data.length;n++){
												if(t_same[k].data[n].mount>0){
													if(t_same[k].data[n].mount>=tcusttmpmount){
														t_same[k].data[n].mount=t_same[k].data[n].mount-tcusttmpmount;
														tcusttmpmount=0;
													}else{
														tcusttmpmount=tcusttmpmount-t_same[k].data[n].mount;
														t_same[k].data[n].mount=0;
													}
													if(t_nor.indexOf((t_same[k].data[n].nor+1).toString())==-1){
														t_nor=t_nor+(t_nor.length>0?',':'')+(t_same[k].data[n].nor+1);
													}
												}
												if(tcusttmpmount<=0){
													break;
												}
											}
											break;
										}
									}
								}
								//更新最後一個物料的配料項次
								if(getucc[getucc.length-1].nor=='')
									getucc[getucc.length-1].nor=t_nor;
								
								//已裁剪完的長度已不需要
								cutlengthb.splice(j, 1);
								j--;
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
							}
						}
					}
					//將板料寫回bbt
					//先清空bbt
					for (var i = 0; i < q_bbtCount; i++) {
						$('#btnMinut__'+i).click();
					}
					while(getucc.length>q_bbtCount){
						$('#btnPlut').click()
					}
					
					//整合基礎螺栓的資料
					var bolt=[],bolts='';
					for (var i = 0; i < q_bbsCount; i++) {
						if(!emp($('#txtProductno_'+i).val()) && !emp($('#txtProduct_'+i).val()) && $('#txtProduct_'+i).val().indexOf('基礎螺栓')>-1){
							var tproduct=$('#txtProduct_'+i).val();
							var tmount=dec($('#txtW07_'+i).val());//dec($('#txtMount_'+i).val());//裁剪數量
							//號數長度
							var tsize=replaceAll(replaceAll(tproduct.split('#')[0]+'#','基礎螺栓',''),'抗震專利','');
							var tlength=dec($('#txtLengthb_'+i).val());
							var n=-1;
							for (var j=0;j<bolt.length;j++){
								if(bolt[j].size==tsize && bolt[j].lengthb==tlength){
									n=j;
									bolt[j].mount=dec(bolt[j].mount)+tmount;
									break;
								}	
							}
							if(n==-1){
								bolt.push({'size': tsize,'lengthb':tlength,'mount':tmount});
							}
						}
					}
					//基礎螺栓 餘料扣除
					var tgetucc=$.extend(true,[], getucc);//getucc.slice();
					tgetucc.sort(function(a, b) { if(dec(a.wlengthb) > dec(b.wlengthb)) {return -1;} if (dec(a.wlengthb) < dec(b.wlengthb)) {return 1;} return 0;});
					//先扣除不用裁剪的螺栓餘料
					for (var i = 0; i < tgetucc.length; i++) {
						var usize=tgetucc[i].size;
						var uwlen=tgetucc[i].wlengthb;
						var umount=tgetucc[i].mount;
						tgetucc[i].wnocut=0;
						if(umount>0){
							for (var j = 0; j < bolt.length; j++) {
								var bsize=bolt[j].size;
								var blen=bolt[j].lengthb;
								var bmount=bolt[j].mount;
								if(usize==bsize && uwlen==blen && bmount>0){//一樣的號數 且長度=螺栓長度
									if(umount>=bmount){
										tgetucc[i].wnocut=tgetucc[i].wnocut+bmount;
										umount=umount-bmount;
										bolt[j].mount=0;
									}else{
										tgetucc[i].wnocut=tgetucc[i].wnocut+umount;
										umount=0;
										bolt[j].mount=bolt[j].mount-umount;
									}
								}
								tgetucc[i].mount=umount;
								if(umount<=0){
									break;
								}
							}
						}
					}
					bolt.sort(function(a, b) { if(a.lengthb > b.lengthb) {return -1;} if (a.lengthb < b.lengthb) {return 1;} return 0;});
					//扣除需裁剪的螺栓餘料
					for (var i = 0; i < tgetucc.length; i++) {
						var usize=tgetucc[i].size;
						var uwlen=tgetucc[i].wlengthb;
						var umount=tgetucc[i].mount;
						if(umount>0){
							var t_cuttmp=[];
							for (var j = 0; j < bolt.length; j++) {
								var bsize=bolt[j].size;
								var blen=bolt[j].lengthb;
								var bmount=bolt[j].mount;
								if(usize==bsize && uwlen>=blen && bmount>0){//一樣的號數 且長度大於螺栓長度
									while(umount>0 &&bmount>0){
										var bcutlen='';
										for (var k = 0; k < bolt.length; k++) {
											if(bsize==bolt[k].size && bolt[k].mount>0)
												bcutlen=bcutlen+(bcutlen.length>0?',':'')+bolt[k].lengthb;
										}
										bcutlen=bcutlen.split(',');
										rep='';
										var t_cup=getmlength(uwlen,uwlen,blen,bcutlen,'',[],0);
										t_cup.sort(function(a, b) { if(a.wrate > b.wrate) {return 1;} if (a.wrate < b.wrate) {return -1;} return 0;});
										//取第一個做最小損耗扣除
										var cupcutlength=t_cup[0].cutlength.split('#')[0].split(',');//切割長度
										var cupcutwlength=t_cup[0].cutlength.split('#')[1];//損耗長度
										var tt_nor='';
										for(var k=0;k<cupcutlength.length;k++){
											if(blen==cupcutlength[k])
												bmount--;
											for(var l=0;l<bolt.length;l++){
												if(cupcutlength[k]==bolt[l].lengthb && bsize==bolt[l].size){
													bolt[l].mount=bolt[l].mount-1;
												}
											}
											var t_n=-1;
											for(var l=0;l<t_cuttmp.length;l++){
												if(t_cuttmp[l].lengthb==cupcutlength[k]){
													t_cuttmp[l].mount=t_cuttmp[l].mount+1;
													t_n=l;
													break;
												}
											}
											if(t_n==-1){
												t_cuttmp.push({'lengthb':cupcutlength[k],'mount':1});
											}
										}
										umount--;
									}
									tgetucc[i].mount=umount;
									if(umount<=0)
										break;
								}
							}
							tgetucc[i].wcut=t_cuttmp;
						}
					}
					//整合基礎螺栓 扣除長度*數量
					for (var i = 0; i < getucc.length; i++) {
						var t_cut='',tlength=0;
						for (var j = 0; j < tgetucc.length; j++) {
							if(getucc[i].size==tgetucc[j].size && getucc[i].spec==tgetucc[j].spec && getucc[i].lengthb==tgetucc[j].lengthb && getucc[i].nor==tgetucc[j].nor){
								if(tgetucc.wnocut>0){
									t_cut=t_cut+(t_cut.length>0?'+':'')+(tgetucc[j].wlengthb+'*'+wnocut.toString());
									tlength=q_add(tlength,q_mul(dec(tgetucc[j].wlengthb),wnocut));
								}
								if(tgetucc[j].wcut!=undefined){
									for (var k = 0; k < tgetucc[j].wcut.length; k++) {
										t_cut=t_cut+(t_cut.length>0?'+':'')+(tgetucc[j].wcut[k].lengthb+'*'+tgetucc[j].wcut[k].mount.toString());
										tlength=q_add(tlength,q_mul(dec(tgetucc[j].wcut[k].lengthb),tgetucc[j].wcut[k].mount));
									}
								}
							}
						}
						getucc[i].bolt=t_cut;
						getucc[i].blength=tlength;
					}
					
					var t_n=0;
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
						
						getucc[i].cutlen.sort(function(a, b) { if(dec(a) > dec(b)) {return -1;} if (dec(a) < dec(b)) {return 1;} return 0;})
							
						var t_lens='',t_mounts=0,t_memo2='';
						for (var j = 0; j < getucc[i].cutlen.length; j++) {
							if(t_lens!='' && t_lens!=getucc[i].cutlen[j]){
								t_memo2=t_memo2+(t_memo2.length>0?'+':'')+t_lens+'*'+t_mounts;
								t_mounts=0;
							}
							t_mounts=t_mounts+1;
							t_lens=getucc[i].cutlen[j];
						}
						//含最後一筆損耗
						if(dec(t_lens)>0){
							t_memo2=t_memo2+(t_memo2.length>0?'+':'')+t_lens+'*'+t_mounts;
						}
						
						//取得產品資料
						var t_where="1=1 and product like '%"+getucc[i].spec+"%' ";
						t_where=t_where+" and product like '%"+getucc[i].size+"%' ";
						t_where=t_where+" and (product like '%"+(getucc[i].lengthb/100).toString()+"M' or product like '%"+(getucc[i].lengthb/100).toString()+".0M' )";
						t_where="where=^^"+t_where+"^^";
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
							$('#txtLengthc__'+t_n).val(dec(t_lens));
							$('#txtScolor__'+t_n).val(getucc[i].bolt);
							$('#txtHard__'+t_n).val(getucc[i].tlength);
						}else{
							$('#txtProductno__'+t_n).val('');
							$('#txtProduct__'+t_n).val('鋼筋熱軋'+getucc[i].spec+' '+getucc[i].size+'*'+(getucc[i].lengthb/100).toString()+'M');
							$('#txtUnit__'+t_n).val('KG');
							$('#txtGmount__'+t_n).val(getucc[i].mount);
							$('#txtGweight__'+t_n).val(round(getucc[i].mount*t_weight*getucc[i].lengthb/100,2));
							$('#txtNor__'+t_n).val(getucc[i].nor);
							$('#txtMemo2__'+t_n).val(t_memo2);
							$('#txtLengthc__'+t_n).val(dec(t_lens));
							$('#txtScolor__'+t_n).val(getucc[i].bolt);
							$('#txtHard__'+t_n).val(getucc[i].tlength);
						}
						t_n++;
					}
					sum();
					Unlock();
				});
			}
			
			//取得組合陣列
			var rep='';
			function getmlength (olength,lengthb,cut,cutlength,cutall,cutarry,repall){//原長度,目前長度,本次裁剪長度,可裁剪長度,裁剪樣式,回傳陣列
				if(rep=="@@"){ //已找到損耗0的組合後續不再處理
					return cutarry;
				}
				if(cut>=0 && lengthb-cut>=0){
					lengthb=lengthb-cut;
					if(cut>0)
						cutall=cutall+(cutall.length>0? ',':'')+cut;
						
					if(lengthb==0){
						//if(rep.indexOf(repall.toString()+'#')==-1){
						//	rep=rep+repall.toString()+'#';
							cutarry.push({'olength':olength,'cutlength':cutall,'wlenhth':lengthb,'wrate':round(lengthb/olength,4)});
						//}
						rep='@@';
						return cutarry;
					}else{
						var nn=0;
						for(var i=0;i<cutlength.length;i++){
							if(lengthb-cutlength[i]>=0){
								repall=repall+Math.pow(2,i);
								getmlength(olength,lengthb,cutlength[i],cutlength,cutall,cutarry,repall);
								nn++;
							}
						}
						if(nn==0){
							cutall=cutall+'#'+lengthb;
							if(rep.indexOf(repall.toString()+'#')==-1){
								rep=rep+repall.toString()+'#';
								cutarry.push({'olength':olength,'cutlength':cutall,'wlenhth':lengthb,'wrate':round(lengthb/olength,4)});
							}
							return cutarry;
						}
					}
				}else{
					cutall=cutall+'#'+lengthb;
					if(rep.indexOf(repall.toString()+'#')==-1){
						rep=rep+repall.toString()+'#';
						cutarry.push({'olength':olength,'cutlength':cutall,'wlenhth':lengthb,'wrate':round(lengthb/olength,4)});
					}
					return cutarry;
				}
				return cutarry;
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
							
							var t_pwhere='1=0';
							for (var j = 0; j < b_ret.length; j++) {
								var t_product=b_ret[j].product;
								t_product=t_product.substr(0,t_product.indexOf('*'))+'*'+(dec(b_ret[j].lengthb)/100).toString()+'M';
								t_pwhere=t_pwhere+" or product='"+t_product+"'"
							}
							
							q_gt('ucc', "where=^^ "+t_pwhere+" ^^" , 0, 0, 0, "getuccsafe",r_accy,1);
							var asucc = _q_appendData("ucc", "", true);
							
							var t_where = "where=^^ ['" + q_date() + "','','') where "+t_pwhere+" group by productno ^^";
							q_gt('work_stk', t_where, 0, 0, 0, "stk", r_accy,1);
							var asstk = _q_appendData("stkucc", "", true);
							
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
							//帶入安全存量和庫存
							for (var j = 0; j < b_ret.length; j++) {
								var t_product=b_ret[j].product;
								t_product=t_product.substr(0,t_product.indexOf('*'))+'*'+(dec(b_ret[j].lengthb)/100).toString()+'M';
								var t_pno='';
								for (var i = 0; i < asucc.length; i++) {
									if(t_product==asucc[i].product){
										b_ret[j].w06=dec(asucc[i].safemount);
										t_pno=asucc[i].noa;
										break;
									}
								}
								for (var i = 0; i < asstk.length; i++) {
									if(t_pno==asstk[i].productno)
										b_ret[j].w05=dec(asstk[i].mount);
										break;
								}
								if(b_ret[j].w05>b_ret[j].w06 && b_ret[j].w05-b_ret[j].mount>b_ret[j].w06){ //庫存足夠
									b_ret[j].w07=0;
								}if(b_ret[j].w06>b_ret[j].w05) //庫存低於安全存量
									b_ret[j].w07=b_ret[j].w06-b_ret[j].w05+dec(b_ret[j].mount);
								else{
									b_ret[j].w07=dec(b_ret[j].mount);
								}
								//處理 是否要彎曲
								if(dec(b_ret[j].fold)>0){
									b_ret[j].sale=true;
								}else{
									b_ret[j].sale=false;
								}
							}
							
							if (b_ret && b_ret[0] != undefined) {
								ret = q_gridAddRow(bbsHtm, 'tbbs', 'txtCustno,txtComp,txtProductno,txtProduct,txtScolor,txtOrdeno,txtNo2,txtLengthb,txtWeight,txtMount,txtMemo,txtDate2,txtW05,txtW06,txtW07'
								, b_ret.length, b_ret, 'custno,cust,productno,product,place,noa,noq,lengthb,weight,mount,memo,odate,w05,w06,w07', 'txtProductno');
								
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
									$('#chkSale_'+i).attr('disabled','disabled');
									if($('#chkSale_'+i).prop('checked')){
										$('#txtProcessno_'+i).removeAttr('disabled');
									}else{
										$('#txtProcessno_'+i).attr('disabled','disabled');
									}
								}
							}
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
			}

			function btnIns() {
				_btnIns();
				$('#txtNoa').val('AUTO');
				$('#txtDatea').val(q_date());
				$('#txtDatea').focus();
				
				$('#txtBdate').val(q_date());
				$('#txtEdate').val(q_cdn(q_date(),7));
				
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
					if(!emp($('#txtProductno_'+j).val()) && !emp($('#txtProduct__'+j).val()) &&!emp($('#txtMemo2__'+j).val()) &&!emp($('#txtNor__'+j).val())){
						var tproduct=$('#txtProduct__'+j).val();
						var tmount=dec($('#txtGmount__'+j).val());//領料數量
						//材質號數長度
						var tspec=tproduct.substr(tproduct.indexOf('S'),tproduct.indexOf(' ')-tproduct.indexOf('S'))
						var tsize=tproduct.split(' ')[1].split('*')[0];
						var tlength=dec(tproduct.split('*')[1])*100;
						var t_memo2s='+'+$('#txtMemo2__'+j).val();
						var t_memo2=$('#txtMemo2__'+j).val().split('+');
						var t_nor=$('#txtNor__'+j).val().split(',');
						var chklength=0;
						for(var k=0;k<t_memo2.length;k++){
							var clength=dec(t_memo2[k].split('*')[0]);
							var cmount=dec(t_memo2[k].split('*')[1]);
							chklength=q_add(chklength,q_mul(clength,cmount));
						}
						if(chklength!=tlength){
							t_err=t_err+'領料 第'+(j+1)+'項 領料長度不等於裁剪總長度!! \n';
						}
						for(var k=0;k<t_nor.length;k++){
							if(t_memo2s.indexOf('+'+$('#txtLengthb_'+(dec(t_nor[k])-1)).val()+'*')==-1){
								t_err=t_err+'領料 第'+(j+1)+'項 裁剪內容 裁剪長度不等於配料長度('+$('#txtLengthb_'+(dec(t_nor[k])-1)).val()+')!! \n';
								break;
							}
						}
					}
				}
				if(t_err.length>0){
					alert(t_err);
					return;
				}
				t_err='';
				var t_same=[];
				//相同材質號數長度合併
				for (var i = 0; i < q_bbsCount; i++) {
					if(!emp($('#txtProductno_'+i).val()) && !emp($('#txtProduct_'+i).val()) && $('#txtProduct_'+i).val().indexOf('鋼筋')>-1){
						var tproduct=$('#txtProduct_'+i).val();
						var tmount=dec($('#txtW07_'+i).val());//dec($('#txtMount_'+i).val());//裁剪數量
						//材質號數長度
						var tspec=tproduct.substr(tproduct.indexOf('S'),tproduct.indexOf(' ')-tproduct.indexOf('S'))
						var tsize=tproduct.split(' ')[1].split('*')[0];
						var tlength=dec($('#txtLengthb_'+i).val());
						var tw03=dec($('#txtW03_'+i).val()); //容許損耗長度
						var tw04=dec($('#txtW04_'+i).val()); //容許損耗%
						
						var t_j=-1;
						for (var j=0;j<t_same.length;j++){
							if(t_same[j].spec==tspec && t_same[j].size==tsize && t_same[j].lengthb==tlength){
								t_j=j;
								t_same[j].data.push({
									'nor':i+1,
									'mount':tmount,
									'w03':tw03,
									'w04':tw04
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
									'w03':tw03,
									'w04':tw04
								}]
							});
						}
					}
				}
				//判斷領料裁剪出的數量是否符合裁剪單的資料
				for (var j = 0; j < q_bbtCount; j++) {
					if(!emp($('#txtProductno_'+j).val()) && !emp($('#txtProduct__'+j).val()) &&!emp($('#txtMemo2__'+j).val()) &&!emp($('#txtNor__'+j).val())){
						var tproduct=$('#txtProduct__'+j).val();
						var tmount=dec($('#txtGmount__'+j).val());//領料數量
						//材質號數長度
						var tspec=tproduct.substr(tproduct.indexOf('S'),tproduct.indexOf(' ')-tproduct.indexOf('S'));
						var tsize=tproduct.split(' ')[1].split('*')[0];
						var tlength=dec(tproduct.split('*')[1])*100;
						var t_memo2=$('#txtMemo2__'+j).val().split('+');
						var t_nor=','+$('#txtNor__'+j).val()+',';
						var t_lengthc=$('#txtLengthc__'+j).val();
						for(var k=0;k<t_memo2.length;k++){
							var clength=dec(t_memo2[k].split('*')[0]);
							var cmount=q_mul(dec(t_memo2[k].split('*')[1]),tmount);
							for (var i=0;i<t_same.length;i++){
								if(t_same[i].spec==tspec && t_same[i].size==tsize && t_same[i].lengthb==clength){
									for (var n=0;n<t_same[i].data.length;n++){
										var t_ccmount=0;
										if(t_nor.indexOf(','+t_same[i].data[n].nor.toString()+',')>-1 && cmount>0){
											if((t_lengthc>t_same[i].data[n].w03 && t_same[i].data[n].w03>0) 
											|| (t_lengthc>t_same[i].data[n].w04*tlength && t_same[i].data[n].w04>0)){
												t_err=t_err+'領料 第'+(j+1)+'項 裁剪組料損耗 超出訂單可損耗長度!! \n';
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
				
				if(t_err.length>0){
					alert(t_err);
					return;
				}
				
				/*var t_err='';
				var ordearry=[],getarry=[];
				for (var i = 0; i < q_bbtCount; i++) {
					var k=-1;
					var tproduct=$('#txtProduct__'+i).val();
					var tmount=dec($('#txtGmount__'+i).val());
					var tnor=$('#txtNor__'+i).val(); //指定配料
					if(tproduct.length>0){
						//材質號數長度
						var tspec=tproduct.substr(tproduct.indexOf('S'),tproduct.indexOf(' ')-tproduct.indexOf('S'))
						var tsize=tproduct.split(' ')[1].split('*')[0];
						var tlength=dec(tproduct.split('*')[1])*100;
						
						for(var j = 0; j<getarry.length; j++){
							if(getarry[j].spec==tspec&& getarry[j].size==tsize && getarry[j].lengthb==tlength && getarry[j].nor==tnor){
								k=j
								break;
							}
						}
						if(k>-1){
							getarry[k].mount=dec(getarry[k].mount)+tmount;
						}else{
							getarry.push({
								'spec':tspec,
								'size':tsize,
								'lengthb':tlength,
								'nor':tnor,
								'mount':tmount,
								'w03':0,
								'w04':0,
								'data':[]
							});
						}
					}
				}
				for(var j = 0; j<getarry.length; j++){
					var ttmount=getarry[j].mount;
					while(ttmount>0){
						getarry[j].data.push({
							'lengthb':getarry[j].lengthb
						});
						ttmount--;
					}
				}
				//訂單裁剪存在陣列排序 由最大長度開始裁剪 減少損耗
				for (var i = 0; i < q_bbsCount; i++) {
					if(!emp($('#txtProductno_'+i).val()) && !emp($('#txtProduct_'+i).val())){
						var tproduct=$('#txtProduct_'+i).val();
						var tmount=dec($('#txtMount_'+i).val());//裁剪數量
						//材質號數長度
						var tspec=tproduct.substr(tproduct.indexOf('S'),tproduct.indexOf(' ')-tproduct.indexOf('S'))
						var tsize=tproduct.split(' ')[1].split('*')[0];
						var tlength=dec($('#txtLengthb_'+i).val());
						var tw03=dec($('#txtW03_'+i).val());
						var tw04=dec($('#txtW04_'+i).val());
						ordearry.push({
							'nor':i+1,
							'spec':tspec,
							'size':tsize,
							'lengthb':tlength,
							'mount':tmount,
							'w03':tw03,
							'w04':tw04
						});
					}
				}
				
				ordearry.sort(function(a, b) {if(a.lengthb>b.lengthb) {return -1;}if (a.lengthb < b.lengthb) {return 1;}return 0;})
				
				//計算損耗
				for (var i = 0; i < ordearry.length; i++) {
					var tmount=ordearry[i].mount;//裁剪數量
					//材質號數長度
					var tnor=ordearry[i].nor.toString();
					var tspec=ordearry[i].spec;
					var tsize=ordearry[i].size;
					var tlength=ordearry[i].lengthb;
					var tw03=ordearry[i].w03;
					var tw04=ordearry[i].w04;
					
					for(var j = 0; j<getarry.length; j++){
						if(getarry[j].nor.toString().split(',').indexOf(tnor)>-1){
							if(getarry[j].spec==tspec&& getarry[j].size==tsize){
								if(getarry[j].lengthb>=tlength && getarry[j].data.length>0){
									//找出底下可以被裁減的長度
									for(var k = 0;k<getarry[j].data.length;k++){
										while(getarry[j].data[k].lengthb>=tlength && tmount>0){
											getarry[j].data[k].lengthb=getarry[j].data[k].lengthb-tlength;
											tmount--;
										}
										if(getarry[j].data[k].lengthb==0){
											getarry[j].data.splice(k, 1);
											k--;
										}else{ //檢查損耗
											if(tw03>0){
												if(getarry[j].data[k].lengthb>tw03 && tw03>0){
													t_err=t_err+"第"+tnor+"項 訂單裁剪損耗超過指定損耗長度!!\n";
												}
											}else{
												var wlength=getarry[j].lengthb*tw04;//可損耗%長度
												if(getarry[j].data[k].lengthb>wlength && wlength>0){
													t_err=t_err+"第"+tnor+"項 訂單裁剪損耗超過指定損耗%!!\n";
												}
											}
										}
										if(tmount==0){
											break;
										}
									}
								}else{
									t_err=t_err+"第"+tnor+"項 與配料長度小於可裁剪長度!!\n";
								}
							}else{
								t_err=t_err+"第"+tnor+"項 與配料材質和號數不符!!\n";
							}
						}
					}
					if(tmount>0){
						t_err=t_err+"第"+tnor+"項 訂單需求數量不符合可裁剪數量!!\n";
					}
				}*/
				
				sum();
				$('#txtWorker').val(r_name);

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
				//低於安全存量
				var t_err='';
				q_gt('ucc', "where=^^ product like '鋼筋%' and product like '%M' and product not like '%中料%' ^^" , 0, 0, 0, "getuccsafe",r_accy,1);
				var asucc = _q_appendData("ucc", "", true);
				
				var t_where = "where=^^ ['" + q_date() + "','','') where product like '鋼筋%' and product like '%M' and product not like '%中料%' group by productno ^^";
				q_gt('work_stk', t_where, 0, 0, 0, "stk", r_accy,1);
				var asstk = _q_appendData("stkucc", "", true);
				
				for (var i = 0; i < asucc.length; i++) {
					var t_safe=dec(asucc[i].safemount);
					var t_pro=asucc[i].noa;
					var t_product=asucc[i].product;
					for (var j = 0; j < asstk.length; j++) {
						if(t_pro==asstk[j].productno){
							if(t_safe>dec(asstk[j].mount)){
								t_err=t_err+(t_err.length>0?'\n':'')+t_product+' 庫存量('+asstk[j].mount+')低於安全存量('+t_safe+')!!';
							}
							break;	
						}
					}
				}
				if(t_err.length>0){
					$('#textStksafe').val(t_err);
					$('#textStksafe').show();
				}else{
					$('#textStksafe').val('');
					$('#textStksafe').hide();
				}
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
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
				$('#lblMo').text('長度');
				$('#lblC1').text('總損耗長度');
				$('#lblCustno_s').text('客戶');
				$('#lblProductno_s').text('品號');
				$('#lblProduct_s').text('品名');
				$('#lblSpec_s').text('材質');
				$('#lblSize_s').text('號數');
				$('#lblLengthb_s').text('裁剪長度');
				$('#lblMount_s').text('訂單數量');
				$('#lblWeight_s').text('重量');
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
				$('#lblW03_s').text('容許損耗長度');
				$('#lblW04_s').text('容許損耗%');
				$('#btnWorkjImport').val('1 = 加工單匯入');
				$('#btnUcccstk').val('2 = 電腦配料');
				$('#lblStatus').text('板料可用長度');
				$('#btnStk').val('庫存量');
				$('#lblW05_s').text('庫存數量');
				$('#lblW06_s').text('安全存量');
				$('#lblW07_s').text('裁剪數量');
				$('#lblScolor_s').text('位置');
				$('#lblMech_s').text('彎曲機台');
				$('#lblSale_s').text('彎曲');
				$('#lblStoreno').text('中料倉庫');
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
				$('#lblMemo2_t').html('裁剪內容/支<br>(裁剪長度*數量+...)');
				$('#lblLengthc_t').text('餘料長度/支');
				$('#lblScolor_t').html('基礎螺栓餘料裁剪內容<br>(裁剪長度*數量+...)');
				$('#lblHard_t').text('基礎螺栓扣除餘料長度');
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
					var t_product=$('#txtProduct_'+j).val();
					if(t_productno.length>0 && t_product.length>0 
						&& t_product.indexOf('3#')==-1 && t_product.indexOf('4#')==-1 && t_product.indexOf('5#')==-1
						&& t_product.indexOf('螺栓')==-1){
						if(q_cur==1 || q_cur==2){
							$('#txtW03_'+j).removeAttr('disabled');
							$('#txtW04_'+j).removeAttr('disabled');
						}
					}else{
						$('#txtW03_'+j).attr('disabled', 'disabled').val('');
						$('#txtW04_'+j).attr('disabled', 'disabled').val('');
					}
					
					$('#chkSale_'+j).attr('disabled','disabled')
					if($('#chkSale_'+j).prop('checked')){
						if(q_cur==1 || q_cur==2){
							$('#txtProcessno_'+j).removeAttr('disabled');
						}
					}else{
						$('#txtProcessno_'+j).attr('disabled','disabled');
					}
				}
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
				width: 2200px;
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
				width: 1850px;
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
		<div id='dmain'>
			<div class="dview" id="dview" >
				<table class="tview" id="tview" >
					<tr>
						<td style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td style="width:80px; color:black;"><a id='vewNoa'> </a></td>
						<td style="width:100px; color:black;"><a id='vewDatea'> </a></td>
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
						<td colspan="2"><select id="cmbMechno" style="font-size: medium"> </select></td>
						<td> </td>
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
						<td><select id="cmbSpec" class="txt c1"> </select></td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td class="cut"><a style="margin-left: 50px;">1.5M內</a></td>
						<td class="cut"><input id="txtM4" type="text" class="txt num c1" style="width: 70%;"/>秒</td>
						<td class="cut"> </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblM1" class="lbl" > </a></td>
						<td><select id="cmbM1" class="txt c1"> </select></td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td class="cut"><a style="margin-left: 50px;">1.5~4M</a></td>
						<td class="cut"><input id="txtM5" type="text" class="txt num c1" style="width: 70%;"/>秒</td>
						<td class="cut"> </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblStatus" class="lbl" > </a></td>
						<td colspan="2" rowspan='3'>
							<!--<input id="txtStatus" type="text" class="txt c1"/>-->
							<select id="cmbStatus" class="txt c1" multiple="multiple"> </select>
						</td>
						<td><input type="button" id="btnUcccstk" style="width:120px;text-align: left;" /></td>
						<td> </td>
						<td class="cut"><a style="margin-left: 50px;">4M~7M</a></td>
						<td class="cut"><input id="txtM6" type="text" class="txt num c1" style="width: 70%;"/>秒</td>
						<td class="cut"> </td>
					</tr>
					<tr>
						<td> </td>
						<td style="color: red;">多選請按Ctrl點選</td>
						<td> </td>
						<td class="cut"><a style="margin-left: 50px;">7M以上</a></td>
						<td class="cut"><input id="txtM7" type="text" class="txt num c1" style="width: 70%;"/>秒</td>
						<td class="cut"> </td>
					</tr>
					<tr>
						<td> </td>
						<td> </td>
						<td> </td>
						<td class="cut">裁剪</td>
						<td class="cut"><input id="txtM8" type="text" class="txt num c1" /></td>
						<td class="cut">秒/刀 </td>
					</tr>
					<tr>
						<!--<td>
							<span> </span><a id="lblStoreno" class="lbl" > </a>
							<input id="chkNotv" type="checkbox" style="float: right;"/>
						</td>
						<td><input id="txtTggno" type="text" class="txt c1"/></td>
						<td><input id="txtTgg" type="text" class="txt c1"/></td>
						<td> </td>-->
						<td><span> </span><a id="lblC1" class="lbl" > </a></td>
						<td><input id="txtC1" type="text" class="txt num c1"/></td>
						<td> </td>
						<td><input type="button" id="btnCubu" style="width:120px;text-align: left;"/></td>
						<td> </td>
						<td class="cut">卸料/刀</td>
						<td class="cut"> </td>
						<td class="cut"> </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl" > </a></td>
						<td colspan="3"><input id="txtMemo" type="text" class="txt c1"/></td>
						<td> </td>
						<td class="cut"><a style="margin-left: 50px;">1.5M內</a></td>
						<td class="cut"><input id="txtBdime" type="text" class="txt num c1" style="width: 70%;" />秒</td>
						<td class="cut"> </td>
					</tr>
					<tr>
						<td align="right"><input type="button" id="btnStk" style="text-align:left;"/></td>
						<td colspan="3" rowspan='2'>
							<textarea id="textStksafe" cols="10" rows="5" style="width: 99%;height: 50px;display: none;"> </textarea>
						</td>
						<td> </td>
						<td class="cut"><a style="margin-left: 50px;">1.5~8M</a></td>
						<td class="cut"><input id="txtEdime" type="text" class="txt num c1" style="width: 70%;"/>秒</td>
						<td class="cut"> </td>
					</tr>
					<tr>
						<td> </td>
						<td> </td>
						<td class="cut"><a style="margin-left: 50px;">8~16M</a></td>
						<td class="cut"><input id="txtOdime" type="text" class="txt num c1" style="width: 70%;"/>秒</td>
						<td class="cut"> </td>
					</tr>
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
						<td style="width:80px;"><a id='lblW05_s'> </a></td>
						<td style="width:80px;"><a id='lblW06_s'> </a></td>
						<td style="width:100px;"><a id='lblW07_s'> </a></td>
						<td style="width:170px;"><a id='lblW01_s'> </a></td>
						<td style="width:100px;"><a id='lblW03_s'> </a></td>
						<td style="width:100px;"><a id='lblW04_s'> </a></td>
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
						<td><input id="txtW05.*" type="text" class="txt c1 num"/></td>
						<td><input id="txtW06.*" type="text" class="txt c1 num"/></td>
						<td><input id="txtW07.*" type="text" class="txt c1 num"/></td>
						<td>
							<input id="txtW01.*" type="text" class="txt c1 num" style="width: 43%;"/>
							<a style="float: left;">~</a>
							<input id="txtW02.*" type="text" class="txt c1 num" style="width: 43%;"/>
						</td>
						<td><input id="txtW03.*" type="text" class="txt c1 num"/></td>
						<td><input id="txtW04.*" type="text" class="txt c1 num"/></td>
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
					<td style="width:200px;text-align: center;"><a id='lblMemo2_t'> </a></td>
					<td style="width:100px;text-align: center;"><a id='lblLengthc_t'> </a></td>
					<td style="width:200px;text-align: center;"><a id='lblScolor_t'> </a></td>
					<td style="width:100px;text-align: center;"><a id='lblHard_t'> </a></td>
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
					<td><input id="txtMemo..*" type="text" class="txt c1"/></td>
					<td><input id="txtMemo2..*" type="text" class="txt c1"/></td>
					<td><input id="txtLengthc..*" type="text" class="txt c1 num"/></td>
					<td><input id="txtScolor..*" type="text" class="txt c1"/></td>
					<td><input id="txtHard..*" type="text" class="txt c1 num"/></td>
				</tr>
			</table>
		</div>
	</body>
</html>