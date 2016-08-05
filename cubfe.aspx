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
			var q_readonly = ['txtNoa'];
			var q_readonlys = ['txtDate2', 'txtOrdeno', 'txtNo2','txtProduct'];
			var q_readonlyt = [];
			var bbmNum = [['txtM2',10,0,1],['txtM3',10,0,1],['txtM4',10,0,1],['txtM5',10,0,1],['txtM6',10,0,1],['txtM7',10,0,1],['txtM8',10,0,1]
			,['txtBdime',10,0,1],['txtEdime',10,0,1],['txtOdime',10,0,1]];
			var bbsNum = [['txtMount',10,0,1],['txtWeight',10,2,1],['txtW01',10,2,1],['txtW02',10,2,1],['txtW03',10,2,1],['txtW04',10,2,1]];
			var bbtNum = [['txtGmount',10,0,1],['txtGweight',10,2,1]];
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
				['txtProductno_', 'btnProduct_', 'ucaucc', 'noa,product,unit', 'txtProductno_,txtProduct_,txtUnit_', 'ucaucc_b.aspx'],
				['txtProductno__', 'btnProduct__', 'ucaucc', 'noa,product,unit', 'txtProductno__,txtProduct__,txtUnit__', 'ucaucc_b.aspx'],
				['txtStoreno__', 'btnStore__', 'store', 'noa,store', 'txtStoreno__,txtStore__', 'store_b.aspx'],
				['txtUno__', '', 'view_uccb', 'uno,productno,product,unit,mount,weight,storeno', ',txtUno__,txtProductno__,txtProduct__,txtUnit__,txtGmount__,txtGweight__,txtStoreno__', 'store_b.aspx']
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
				for (var j = 0; j < q_bbsCount; j++) {
					var t_dime = dec($('#txtDime_' + j).val());
					$('#txtBdime_' + j).val(round(q_mul(t_dime, 0.93), 2));
					$('#txtEdime_' + j).val(round(q_mul(t_dime, 1.07), 2));
				}
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
				as.sort(function(a, b){if (a.typea > b.typea) {return 1;}if (a.typea < b.typea) {return -1;}});
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
				/*q_gt('adsize', "where=^^1=1 and mon!='' ^^", 0, 0, 0, "getadsize",r_accy,1); //長度
				var as = _q_appendData("adsize", "", true);
				as.sort(function(a, b){if (a.mon > b.mon) {return 1;}if (a.mon < b.mon) {return -1;}});
				t_item = " @ ";
				if (as[0] != undefined) {
					for ( i = 0; i < as.length; i++) {
						t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].mon + '@' + as[i].mon;
					}
				}
				q_cmbParse("cmbMo", t_item);*/
				
				$('#btnWorkjImport').click(function() {
					var t_mech=$('#cmbMechno').val();
					var t_bdate = trim($('#txtBdate').val());
					var t_edate = trim($('#txtEdate').val());
					var t_spec = dec($('#cmbSpec').val());
					var t_m1 = dec($('#cmbM1').val());
					//外調定尺不用裁剪
					var t_where = " 1=1 and (mech1='"+t_mech+"' or mech2='"+t_mech+"' or mech3='"+t_mech+"' or mech4='"+t_mech+"' or mech5='"+t_mech+"')";
					t_bdate = (emp(t_bdate) ? '' : t_bdate);
					t_edate = (emp(t_edate) ? r_picd : t_edate);
					t_where += " and (a.odate between '" + t_bdate + "' and '" + t_edate + "') ";
					if(t_spec.length>0){
						t_where += " and (b.product like '%" + t_spec + "%') ";
					}
					if(t_m1.length>0){
						t_where += " and (b.product like '%" + t_m1 + "%') ";
					}
					
					q_box("workjsfe_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'workjsfe_b', "95%", "95%", q_getMsg('popOrde'));
				});
				
				$('#btnCubu').click(function() {
					if (q_cur == 0 || q_cur==4) {
						var t_where = "noa='" + trim($('#txtNoa').val()) + "'";
						q_box("cubufe_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where + ";"+r_accy, 'cubu', "95%", "95%", q_getMsg('popCubu'));
					}
				});
				
				$('#btnUcccstk').click(function() {
					var t_err='';
					var t_same=[];
					//相同材質號數合併
					for (var i = 0; i < q_bbsCount; i++) {
						if(!emp($('#txtProductno_'+i).val()) && !emp($('#txtProduct_'+i).val())){
							var tproduct=$('#txtProduct_'+i).val();
							var tmount=dec($('#txtMount_'+i).val());//裁剪數量
							var tweight=dec($('#txtWeight_'+i).val());//裁剪數量
							//材質號數長度
							var tspec=tproduct.substr(tproduct.indexOf('S'),tproduct.indexOf(' ')-tproduct.indexOf('S'))
							var tsize=tproduct.split(' ')[1].split('*')[0];
							var tlength=dec($('#txtLengthb_'+i).val());
							var tw03=dec($('#txtW03_'+i).val()); //容許損耗長度
							var tw04=dec($('#txtW04_'+i).val()); //容許損耗%
							
							var t_j=-1;
							for (var j=0;j<t_same.length;j++){
								if(t_same[j].spec==tspec && t_same[j].size==tsize){
									t_j=j;
									t_same[j].data.push({
										'nor':i,
										'tlengthb':tlength,
										'mount':tmount,
										'weight':tweight,
										'w03':tw03,
										'w04':tw04
									})
								}
							}
							
							if(t_j<0){
								t_same.push({
									'spec':tspec,
									'size':tsize,
									'data':{
										'nor':i,
										'tlengthb':tlength,
										'mount':tmount,
										'weight':tweight,
										'w03':tw03,
										'w04':tw04
									}
								});
							}
						}
					}
					var nbbt=0;
					
					for (var j=0;j<t_same.length;j++){
						//材質號數
						var tspec=t_same[j].spec;
						var tsize=t_same[j].size;
						
						//讀取相同材質號數的庫存
						var t_where=" ['" + q_date() + "','','') where (storeno like '[A-Z]' or isnull(storeno,'')='') and mount>0 and weight>0 ";
						var t_where=" and product like '%"+tspec+"%' ";
						var t_where=" and product like '%"+tsize+"%' ";
						var t_where=" and product like '%M' ";
						//var t_where=" and cast(substring(product,charindex('*',product)+1,charindex('M',product)-charindex('*',product)-1) as float)*100>"+tlength+" ";
						var t_where=" order by productno,storeno";
						t_where="where=^^"+t_where+"^^";
						q_gt('calstk', t_where, 0, 0, 0, "getstk",r_accy,1);
						var as = _q_appendData("stkucc", "", true);
						if (as[0] != undefined) {
							//判斷庫存是否有符合的長度
							for (var k=0;k<t_same[j].data.length;k++){
								var t_n=t_same[j].data[k].nor;//訂單序
								var tmount=dec(t_same[j].data[k].mount);//裁剪數量
								var tweight=dec(t_same[j].data[k].weight);//裁剪重量
								var tlength=dec(t_same[j].data[k].tlengthb);//裁剪長度
								var tavgweight=round(tweight/tmount,2);
								
								for (var m=0;m<as.length;m++){
									var slength=dec(as[m].product.split('*')[1])*100;//庫存長度
									var smount=dec(as[m].mount);//庫存數量
									var sweight=dec(as[m].weight);//庫存重量
									
									if(slength==tlength){//符合的長度
										if(smount>=tmount){
											$('#txtProductno__'+nbbt).val(as[m].productno);
											$('#txtProduct__'+nbbt).val(as[m].product);
											$('#txtUnit__'+nbbt).val(as[m].unit);
											$('#txtGmount__'+nbbt).val(tmount);
											$('#txtGweight__'+nbbt).val(tweight);
											$('#txtStoreno__'+nbbt).val(as[m].storeno);
											$('#txtStore__'+nbbt).val(as[m].store);
											$('#txtNor__'+nbbt).val(t_n);
											as[m].mount=as[m].mount-tmount;
											as[m].weight=as[m].weight-tweight;
											tmount=0;
											tweight=0;
											nbbt++;
										}else{
											$('#txtProductno__'+nbbt).val(as[m].productno);
											$('#txtProduct__'+nbbt).val(as[m].product);
											$('#txtUnit__'+nbbt).val(as[m].unit);
											$('#txtGmount__'+nbbt).val(as[m].mount);
											$('#txtGweight__'+nbbt).val(round(as[m].mount*tavgweight,2));
											$('#txtStoreno__'+nbbt).val(as[m].storeno);
											$('#txtStore__'+nbbt).val(as[m].store);
											$('#txtNor__'+nbbt).val(t_n);
											as[m].mount=0;
											as[m].weight=0;
											tmount=tmount-as[m].mount;
											tweight=tweight-round(as[m].mount*tavgweight,2);
											nbbt++;
										}
									}
									if(tmount<=0){
										break;
									}
									if(as[m].mount==0){
										as.splice(m, 1);
										m--;
									}
								}
								if(tmount<=0){
									t_same[j].data.splice(k, 1);
									k--;
								}
							}
							
							//庫存無剛好長度 需合併裁剪
							/*//3#.4#.5# 需定尺入庫
							 if(tsize=='3#' || tsize=='4#' || tsize=='5#'){
								//組合配料
								//取出剩餘長度 進行組合
								var alength='';
								for (var k=0;k<t_same[j].data.length;k++){
									var t_n=t_same[j].data[k].nor;//訂單序
									var tmount=dec(t_same[j].data[k].mount);//裁剪數量
									var tweight=dec(t_same[j].data[k].weight);//裁剪重量
									var tlength=dec(t_same[j].data[k].tlengthb);//裁剪長度
									var tavgweight=round(tweight/tmount,2);
									alength=alength+tlength+',';
								}
								
								
								//最小定尺合併裁剪
							}else{
								//組合配料
								
								//最小損耗材剪
							}*/
						}else{
							for (var k=0;k<t_same[j].data.length;k++){
								t_err=t_err+"第"+k+"項 無庫存可以裁剪!! \n";
							}
						}
					}
					
				});
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
					case 'ordet':
						var as = _q_appendData("ordet", "", true);
						for (var j = 0; j < as.length; j++) {
							for (var i = 0; i < q_bbtCount; i++) {
								var t_uno = $('#txtUno__' + i).val();
								if (as[j] && as[j].noa == t_uno) {
									b_ret.splice(j, 1);
								}
							}
						}
						if (as[0] != undefined) {
							q_gridAddRow(bbtHtm, 'tbbt', 'txtUno', as.length, as, 'uno', 'txtUno', '__');
							/// 最後 aEmpField 不可以有【數字欄位】
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
							for (var j = 0; j < b_ret.length; j++) {
								for (var i = 0; i < q_bbtCount; i++) {
									var t_ordeno = $('#txtOrdeno_' + i).val();
									var t_no2 = $('#txtNo2_' + i).val();
									if (b_ret[j] && b_ret[j].noa == t_ordeno && b_ret[j].noq == t_no2) {
										b_ret.splice(j, 1);
									}
								}
							}
							if (b_ret && b_ret[0] != undefined) {
								ret = q_gridAddRow(bbsHtm, 'tbbs', 'txtCustno,txtComp,txtProductno,txtProduct,txtOrdeno,txtNo2,txtLengthb,txtWeight,txtMount,txtMemo,txtDate2'
								, b_ret.length, b_ret, 'custno,cust,productno,product,noa,noq,lengthb,weight,mount,memo,odate', 'txtProductno');
							}
							sum();
							b_ret = '';
						}
						break;
					case 'uccc':
						if (!b_ret || b_ret.length == 0) {
							b_pop = '';
							return;
						}
						if (q_cur > 0 && q_cur < 4) {
							for (var j = 0; j < b_ret.length; j++) {
								for (var i = 0; i < q_bbtCount; i++) {
									var t_uno = $('#txtUno__' + i).val();
									if (b_ret[j] && b_ret[j].noa == t_uno) {
										b_ret.splice(j, 1);
									}
								}
							}
							if (b_ret[0] != undefined) {
								ret = q_gridAddRow(bbtHtm, 'tbbt', 'txtUno,txtGmount,txtGweight,txtWidth,txtLengthb', b_ret.length, b_ret, 'uno,emount,eweight,width,lengthb', 'txtUno', '__');
								/// 最後 aEmpField 不可以有【數字欄位】
							}
							sum();
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
				var ordearry=[],getarry=[];
				for (var i = 0; i < q_bbtCount; i++) {
					var k=-1;
					var tproduct=$('#txtProduct__'+i).val();
					var tmount=dec($('#txtGmount__'+i).val());
					var tnor=dec($('#txtNor__'+i).val()); //指定配料
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
				for(var j = 0; j<getarry.length; j++){
					var ttmount=getarry[i].mount;
					while(ttmount>0){
						getarry[i].data.push({
							'lengthb':getarry[i].lengthb
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
							'nor':i,
							'spec':tspec,
							'size':tsize,
							'lengthb':tlength,
							'mount':tmount,
							'w03':tw03,
							'w04':tw04
						});
					}
				}
				
				ordearry.sort(function(a, b) {if(a.lengthb>b.lengthb) {return 1;}if (a.lengthb < b.lengthb) {return -1;}return 0;})
				
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
						if(getarry[j].nor.split(',').indexOf(tnor)>-1){
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
												if(getarry[j].data[k].lengthb>tw03){
													t_err=t_err+"第"+tnor+"項 訂單裁剪損耗超過指定損耗長度!!\n";
												}
											}else{
												var wlength=getarry[j].lengthb*tw04;//可損耗%長度
												if(getarry[j].data[k].lengthb>wlength){
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
				}
				
				if(t_err.length>0){
					alert(t_err);
				}
				
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
				if (parseFloat(as['mount'].length==0?"0":as['mount'])==0 && parseFloat(as['weight'].length==0?"0":as['weight'])==0) {
					as[bbsKey[1]] = '';
					return;
				}
				q_nowf();
				as['noa'] = abbm2['noa'];
				return true;
			}

			function bbtSave(as) {
				if (!as['uno']) {
					as[bbtKey[1]] = '';
					return;
				}
				q_nowf();
				return true;
			}

			function refresh(recno) {
				_refresh(recno);
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
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
				
				$('#lblMech').text('裁剪方式');
				$('#lblSpec').text('材質');
				$('#lblM1').text('號數');
				$('#lblMo').text('長度');
				$('#lblCustno_s').text('客戶');
				$('#lblProductno_s').text('品號');
				$('#lblProduct_s').text('品名');
				$('#lblSpec_s').text('材質');
				$('#lblSize_s').text('號數');
				$('#lblLengthb_s').text('裁剪長度');
				$('#lblMount_s').text('數量');
				$('#lblWeight_s').text('重量');
				$('#lblNeed_s').text('需求');
				$('#lblMemo_s').text('備註');
				$('#lblDate2_s').text('預交日');
				$('#lblEnda_s').text('結案');
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
					}
				}
				_bbtAssign();
				
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
						&& t_product.indexOf('3#')==-1 && t_product.indexOf('4#')==-1 && t_product.indexOf('5#')==-1){
						if(q_cur==1 || q_cur==2){
							$('#txtW02_'+j).removeAttr('disabled');
							$('#txtW03_'+j).removeAttr('disabled');
						}
					}else{
						$('#txtW02_'+j).attr('disabled', 'disabled').val('');
						$('#txtW03_'+j).attr('disabled', 'disabled').val('');
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
				width: 800px;
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
				width: 1850px;
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
				width: 1240px;
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
						<td><input type="button" id="btnUcccstk" style="width:120px;text-align: left;" /></td>
						<td> </td>
						<td class="cut"><a style="margin-left: 50px;">1.5M內</a></td>
						<td class="cut"><input id="txtM4" type="text" class="txt num c1" style="width: 70%;"/>秒</td>
						<td class="cut"> </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblM1" class="lbl" > </a></td>
						<td><select id="cmbM1" class="txt c1"> </select></td>
						<td> </td>
						<td><input type="button" id="btnCubu" style="width:120px;text-align: left;"/></td>
						<td> </td>
						<td class="cut"><a style="margin-left: 50px;">1.5~4M</a></td>
						<td class="cut"><input id="txtM5" type="text" class="txt num c1" style="width: 70%;"/>秒</td>
						<td class="cut"> </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl" > </a></td>
						<td colspan="3"><input id="txtMemo" type="text" class="txt c1"/></td>
						<td> </td>
						<td class="cut"><a style="margin-left: 50px;">4M~7M</a></td>
						<td class="cut"><input id="txtM6" type="text" class="txt num c1" style="width: 70%;"/>秒</td>
						<td class="cut"> </td>
					</tr>
					<tr>
						<td colspan="5"> </td>
						<td class="cut"><a style="margin-left: 50px;">7M以上</a></td>
						<td class="cut"><input id="txtM7" type="text" class="txt num c1" style="width: 70%;"/>秒</td>
						<td class="cut"> </td>
					</tr>
					<tr>
						<td colspan="5"> </td>
						<td class="cut">裁剪</td>
						<td class="cut"><input id="txtM8" type="text" class="txt num c1" /></td>
						<td class="cut">秒/刀 </td>
					</tr>
					<tr>
						<td colspan="5"> </td>
						<td class="cut">卸料/刀</td>
						<td class="cut"> </td>
						<td class="cut"> </td>
					</tr>
					<tr>
						<td colspan="5"> </td>
						<td class="cut"><a style="margin-left: 50px;">1.5M內</a></td>
						<td class="cut"><input id="txtBdime" type="text" class="txt num c1" style="width: 70%;" />秒</td>
						<td class="cut"> </td>
					</tr>
					<tr>
						<td colspan="5"> </td>
						<td class="cut"><a style="margin-left: 50px;">1.5~8M</a></td>
						<td class="cut"><input id="txtEdime" type="text" class="txt num c1" style="width: 70%;"/>秒</td>
						<td class="cut"> </td>
					</tr>
					<tr>
						<td colspan="5"> </td>
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
						<!--<td style="width:40px;"><a id='lblUnit_s'> </a></td>
						<td style="width:100px;"><a id='lblSpec_s'> </a></td>
						<td style="width:80px;"><a id='lblSize_s'> </a></td>-->
						<!--<td style="width:60px;"><a id='lblClass'> </a></td>-->
						<td style="width:80px;"><a id='lblLengthb_s'> </a></td>
						<td style="width:80px;"><a id='lblMount_s'> </a></td>
						<td style="width:100px;"><a id='lblWeight_s'> </a></td>
						<td style="width:170px;"><a id='lblW01_s'> </a></td>
						<td style="width:100px;"><a id='lblW03_s'> </a></td>
						<td style="width:100px;"><a id='lblW04_s'> </a></td>
						<td style="width:150px;"><a id='lblNeed_s'> </a></td>
						<td><a id='lblMemo_s'> </a></td>
						<td style="width:90px;"><a id='lblDate2_s'> </a></td>
						<td style="width:30px;"><a id='lblEnda_s'> </a></td>
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
						<!--<td><input id="txtUnit.*" type="text" class="txt c1"/></td>
						<td><input id="txtSpec.*" type="text" class="txt c1"/></td>
						<td><input id="txtSize.*" type="text" class="txt c1"/></td>-->
						<!--<td><input id="txtClass.*" type="text" class="txt c1"/></td>-->
						<td><input id="txtLengthb.*" type="text" class="txt c1 num"/></td>
						<td><input id="txtMount.*" type="text" class="txt c1 num"/></td>
						<td><input id="txtWeight.*" type="text" class="txt c1 num"/></td>
						<td>
							<input id="txtW01.*" type="text" class="txt c1 num" style="width: 43%;"/>
							<a style="float: left;">~</a>
							<input id="txtW02.*" type="text" class="txt c1 num" style="width: 43%;"/>
						</td>
						<td><input id="txtW03.*" type="text" class="txt c1 num"/></td>
						<td><input id="txtW04.*" type="text" class="txt c1 num"/></td>
						<td><input id="txtNeed.*" type="text" class="txt c1"/></td>
						<td><input id="txtMemo.*" type="text" class="txt c1"/></td>
						<td><input id="txtDate2.*" type="text" class="txt c1"/></td>
						<td><input id="chkEnda.*" type="checkbox"/></td>
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
				</tr>
			</table>
		</div>
	</body>
</html>