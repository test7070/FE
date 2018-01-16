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
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">
            var q_name = "img";
            var q_readonly = [];
            var q_readonlys = [];
            var q_readonlyt = [];
            var bbmNum = [];
            var bbsNum = [];
            var bbtNum = [];
            var bbmMask = [];
            var bbsMask = [];
            var bbtMask = [];
     		
     		q_tables = 't';
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
			brwCount2 =8;
			aPop = new Array(
				['txtMechno_', 'btnMechno_', 'mech', 'noa,mech', 'txtMechno_,txtMech_', "mech_b.aspx?" ]
            	, ['txtCustno__', 'btnCustno__', 'cust', 'noa,comp', 'txtCustno__,txtComp__', "cust_b.aspx?" ]
				
			);
            				
            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                bbtKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1);
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
                bbmNum = [['txtFold',10,0,1],['txtOfflength',10,0,1]];
                bbsNum = [['txtLbottom',10,0,1],['txtSbottom',10,0,1],['txtLfoot',10,0,1],['txtSfoot',10,0,1]];
            	bbtNum = [['txtBtol',10,0,1],['txtRtol',10,0,1],['txtBottom',10,0,1],['txtFoot',10,0,1]];
                
                $('#txtNoa').change(function(e) {			
					t_where = "where=^^ noa='" + $(this).val() + "'^^";
					q_gt('img', t_where, 0, 0, 0, "checkNoa_change", r_accy);				
				});
				$('#btnFile').change(function(e){
					event.stopPropagation(); 
				    event.preventDefault();
					file = $('#btnFile')[0].files[0];
					if(file){
						fr = new FileReader();
					    fr.readAsDataURL(file);
					    fr.onloadend = function(e){
					    	$('#imgPic').attr('src',fr.result);
					    	$('#btnFile').val('');
					    	refreshImg(true);
					    };
					}
				});
				$('#textPara').change(function(e){
					if(q_cur==1 || q_cur==2){
						refreshPara();
					}
				});
				$('#textPara').focusout(function(e){
					if(q_cur==1 || q_cur==2){
						refreshPara();
					}
				});
				
				if(q_getPara('sys.project').toUpperCase()=='FE'){
					$('.fe').show();
					$('.dbbs').show();
					$('#dbbt').show();
				}
				
				if(q_getPara('sys.project').toUpperCase()=='VU' || q_getPara('sys.project').toUpperCase()=='SF'){
					$('.sf').show();
				}
            }
            
            function refreshPara(){
            	var string = $.trim($('#textPara').val());
				var t_para = new Array();
				var value = string.split('\n');
				for(var i=0;i<value.length;i++){
					if(value[i].split(',').length==4){
						try{
							t_para.push({key:value[i].split(',')[0]
								,top:parseInt(value[i].split(',')[1])
								,left:parseInt(value[i].split(',')[2])
								,fontsize:value[i].split(',')[3]});
						}catch(e){
						}
					}
				}
				$('#txtPara').val(JSON.stringify(t_para));
				refreshImg(false);
            }
            
			function refreshImg(isOrg){
				var image = document.getElementById('imgPic');
				var c = document.getElementById("canvas");
				if(!isOrg){
					image.src=$('#txtOrg').val();
				}
				image.onload = function() {
					var imgwidth = $('#imgPic').width();
	                var imgheight = $('#imgPic').height();
	                $('#canvas').width(imgwidth).height(imgheight);
					var ctx = c.getContext("2d");		
					c.width = imgwidth;
					c.height = imgheight;
					ctx.drawImage($('#imgPic')[0],0,0,imgwidth,imgheight);
					if(!isOrg && $('#textPara').val().length>0){
						t_para = JSON.parse($('#txtPara').val());
						$('#textPara').val('');
						for(var i=0;i<t_para.length;i++){
							ctx.font = t_para[i].fontsize+"px times new roman";
							ctx.fillStyle = 'red';
							if(q_getPara('sys.project').toUpperCase()=='SF' || q_getPara('sys.project').toUpperCase()=='VU'){
								ctx.textAlign="center";
							}
							ctx.fillText(t_para[i].key,t_para[i].left,t_para[i].top);
							if($('#textPara').val().length>0)
								$('#textPara').val($('#textPara').val()+'\n');
							$('#textPara').val($('#textPara').val()+t_para[i].key+','+t_para[i].top+','+t_para[i].left+','+t_para[i].fontsize);
						}
					}
					image.src=c.toDataURL();
					//$('#imgPic').attr('src',c.toDataURL());
					refreshImg2(isOrg);
				}
			}
			
			function refreshImg2(isOrg){
				var image = document.getElementById('imgPic');
				var c = document.getElementById("canvas");
				image.onload = function() {
					if(isOrg){
						var imgwidth = $('#imgPic').width();
	                	var imgheight = $('#imgPic').height();
						//縮放為300*100
						$('#canvas').width(300).height(100);
						c.width = 300;
						c.height = 100;
						$("#canvas")[0].getContext("2d").drawImage($('#imgPic')[0],0,0,imgwidth,imgheight,0,0,300,100);
						$('#txtOrg').val(c.toDataURL());
						
						if(q_getPara('sys.project').toUpperCase()=='SF'){
							//106/08/10 SF預先產生圖片
							$('#imgPic_sf').attr('src',$('#txtOrg').val());
							refreshImgSF_3();
						}else{
							refreshImg(false);
						}
					}
					else
						$('#txtData').val(c.toDataURL());
				}
			}
			
			function refreshImgSF_3(){
				var imagesf = document.getElementById('imgPic_sf');
				var imgwidth = 300;
                var imgheight = 100;
				imagesf.onload = function() {
					var cx = document.getElementById("canvas_sf");
					cx.getContext("2d");
					$('#canvas_sf').width(355).height(119);
					cx.width = 355;
					cx.height = 119;
					$("#canvas_sf")[0].getContext("2d").drawImage($('#imgPic_sf')[0],0,0,imgwidth,imgheight,0,0,355,119);
					$('#txtBarcode').val(cx.toDataURL());
					
					cx.getContext("2d");
					$('#canvas_sf').width(150).height(50);
					cx.width = 150;
					cx.height = 50;
					$("#canvas_sf")[0].getContext("2d").drawImage($('#imgPic_sf')[0],0,0,imgwidth,imgheight,0,0,150,50);
					$('#txtImgdata').val(cx.toDataURL());
					
					refreshImg(false);
				}
			}
			
            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case q_name + '_s':
                        q_boxClose2(s2);
                        break;
                } 
            }
            
            function q_gtPost(t_name) {
                switch (t_name) {
                	case 'checkNoa_change':
						var as = _q_appendData("img", "", true);
						if (as[0] != undefined) {
							alert('已存在 ' + as[0].noa + ' ' + as[0].namea);
							Unlock(1);
							return;
						}
						break;
                	case 'checkNoa_btnOk':
						var as = _q_appendData("img", "", true);
						if (as[0] != undefined) {
							alert('已存在 ' + as[0].noa + ' ' + as[0].namea);
							Unlock(1);
							return;
						} else {
							wrServer($('#txtNoa').val());
						}
						break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
                q_box('imgfe_s.aspx', q_name + '_s', "500px", "310px", q_getMsg("popSeek"));
            }

            function btnIns() {
                _btnIns();
                refreshBbm();
                $('#txtNoa').focus();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                refreshBbm();
                $('#txtNamea').focus();
            }

            function btnPrint() {

            }
			function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                Unlock(1);
            }
            function btnOk() {
            	Lock(1,{opacity:0});
            	if($('#txtNoa').val().length==0){
            		alert('請輸入'+q_getMsg("lblNoa"));
            		Unlock(1);
            		return;
            	}
				if (q_cur == 1) {
					t_where = "where=^^ noa='" + $('#txtNoa').val() + "'^^";
					q_gt('img', t_where, 0, 0, 0, "checkNoa_btnOk");
				} else {
					wrServer($('#txtNoa').val());
				}          	
            }

            function wrServer(key_value) {
                var i;

                xmlSql = '';
                if (q_cur == 2)/// popSave
                    xmlSql = q_preXml();

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function refresh(recno) {
                _refresh(recno);     
                refreshBbm();
            }
            
			function refreshBbm(){
            	if(q_cur==1){
            		$('#txtNoa').css('color','black').css('background','white').removeAttr('readonly');
            	}else{
            		$('#txtNoa').css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
            	}
            	if(q_cur==1 || q_cur==2)
                	$('#btnFile').removeAttr('disabled');
                else
                	$('#btnFile').attr('disabled','disabled');
            	$('#imgPic').attr('src',$('#txtData').val());
                for(var i=0;i<brwCount2;i++){
                	$('#vtimg_'+i).children().attr('src',$('#vtdata_'+i).text());
                }
                try{
                	t_para = JSON.parse($('#txtPara').val());
					$('#textPara').val('');
					for(var i=0;i<t_para.length;i++){
						if($('#textPara').val().length>0)
							$('#textPara').val($('#textPara').val()+'\n');
						$('#textPara').val($('#textPara').val()+t_para[i].key+','+t_para[i].top+','+t_para[i].left+','+t_para[i].fontsize);
					}
                }catch(e){
                	
                }
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
            }
            
            function bbsAssign() {
            	for (var i = 0; i < q_bbsCount; i++) {
            	}
                _bbsAssign();
            }
            
            function bbsSave(as) {
                if (!as['mechno'] && !as['mech']) {
                    as[bbsKey[1]] = '';
                    return;
                }
                q_nowf();
                return true;
            }
            
            function bbtAssign() {
                for (var i = 0; i < q_bbtCount; i++) {
                }
                _bbtAssign();
            }
            
            function bbtSave(as) {/// 表身 寫入資料庫前，寫入需要欄位
				if (!as['custno'] && !as['comp']) {//不存檔條件
					as[bbsKey[1]] = '';
					return;
				}
				q_nowf();
				return true;
			}

            function btnMinus(id) {
                _btnMinus(id);
            }

            function btnPlus(org_htm, dest_tag, afield) {
                _btnPlus(org_htm, dest_tag, afield);
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
		</script>

		<style type="text/css">
            #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 350px; 
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
                width: 600px;
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
                width: 20%;
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
            }
            .tbbm tr td .lbl.btn:hover {
                color: #FF8F19;
            }
            .txt.c1 {
                width: 100%;
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
            }
            .num {
                text-align: right;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            select {
                font-size: medium;
            }
            .dbbs {
                width: 700px;
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
                width: 700px;
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
		<div style="overflow: auto;display:block;width:1050px;">
			<!--#include file="../inc/toolbar.inc"-->
		</div>
		<div style="overflow: auto;display:block;width:1280px;">
			<div class="dview" id="dview" >
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:120px; color:black;"><a id='vewImg'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewNoa'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewNamea'> </a></td>
						<td align="center" style="display:none;"><a id='vewData'> </a></td>
					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox" style=' '/></td>
						<td id='img' style="text-align: center;"><img src="" style="width:120px;height:40px;"/></td>
						<td id='noa' style="text-align: center;">~noa</td>
						<td id='namea' style="text-align: left;">~namea</td>
						<td id='data' style="display:none;">~data</td>
					</tr>
				</table>
			</div>
			<div class='dbbm' >
				<table class="tbbm"  id="tbbm">
					<tbody>
						<tr style="height:1px;">
							<td> </td>
							<td> </td>
							<td> </td>
							<td class="tdZ"> </td>
						</tr>
						<tr>
							<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
							<td colspan="2"><input id="txtNoa"  type="text"  class="txt c1"/></td>
						</tr>
						<tr>
							<td><span> </span><a id='lblNamea' class="lbl"> </a></td>
							<td colspan="2">
								<input id="txtNamea"  type="text" class="txt c1" />	
								<input id="txtData"  type="text" style="display:none;" />
								<input id="txtOrg"  type="text" style="display:none;"/>
								<input id="txtImgdata"  type="text" style="display:none;"/>
								<input id="txtBarcode"  type="text" style="display:none;"/>
								<input id="txtPara"  type="text" style="display:none;" />	
							</td>
						</tr>
						<tr class="fe" style="display: none;">
							<td><span> </span><a id='lblOfflength' class="lbl"> </a></td>
							<td><input id="txtOfflength"  type="text"  class="txt num c1" style="width: 50px;"/></td>
						</tr>
						<tr class="fe" style="display: none;">
							<td><span> </span><a id='lblFold' class="lbl"> </a></td>
							<td>
								<input id="txtFold"  type="text" class="txt num c1" style="width: 50px;"/>
								<span style="float: left;width: 50px;"> </span>
								<a id='lblIscoupler' class="lbl" style="float: left;"> </a>
								<span style="float: left;"> </span>
								<input id="chkIscoupler" type="checkbox"/>
							</td>
						</tr>
						<tr>
							<td> </td>
							<td colspan="2"><a style="color:#8A4B08;">代號,TOP,LEFT,字形大小</a></td>
						</tr>
						<tr> 
							<td><span> </span><a id='lblPara' class="lbl"> </a></td>
							<td colspan="2" rowspan="4" style="vertical-align: top;">
								<textarea id="textPara" class="txt c1" rows="6"> </textarea>
								<a class="sf" style="display: none;color: red;">※參數A-E為長度，參數F-G為續接器</a>
							</td>
						</tr>
						<tr> </tr>
						<tr> </tr>
						<tr> </tr>
						<tr>
							<td><span> </span><a id='lblImgpci' class="lbl"> </a></td>
							<td colspan="2" rowspan="4">
								<img id="imgPic" src="" style="width:300px;height:100px;"/>
								<img id="imgPic_sf" src="" style="width:300px;height:100px;display: none;"/>
								<canvas id="canvas" style="display:none"> </canvas>
								<canvas id="canvas_sf" style="display:none"> </canvas><!--SF用-->
							</td>
						</tr>
						<tr> </tr>
						<tr> </tr>
						<tr> </tr>
						<tr>
							<td> </td>
							<td colspan="3">
								<input type="file" id="btnFile" value="上傳"/>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<div class='dbbs'  style="display: none;">
			<table id="tbbs" class='tbbs' style=' text-align:center'>
				<tr style='color:white; background:#003366;' >
					<td  align="center" style="width:30px;"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /></td>
					<td align="center" style="width:200px;"><a id='lblMech_s'> </a></td>
					<td align="center" style="width:180px;"><a id='lblBottom_s'> </a></td>
					<td align="center" style="width:180px;"><a id='lblFoot_s'> </a></td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td align="center">
						<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
						<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td>
						<input id="txtMechno.*" type="text" style="float:left;width: 25%;"/>
						<input id="btnMechno.*" type="button" value="." style="float:left;width: 1%;"/>
						<input id="txtMech.*" type="text" style="float:left;width: 60%;"/>
					</td>
					<td>
						<input id="txtLbottom.*" type="text" class="txt num c1" style="width: 45%;"/>
						<a style="float: left;">~</a>
						<input id="txtSbottom.*" type="text" class="txt num c1" style="width: 45%;"/>
					</td>
					<td>
						<input id="txtLfoot.*" type="text" class="txt num c1" style="width: 45%;"/>
						<a style="float: left;">~</a>
						<input id="txtSfoot.*" type="text" class="txt num c1" style="width: 45%;"/>
					</td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
		<div id="dbbt" style="display: none;">
			<table id="tbbt">
				<tr style="color:white; background:#003366;">
					<td style="width:20px;"><input id="btnPlut" type="button" style="font-weight: bold;" value="+"/></td>
					<td align="center" style="width:130px;"><a id='lblCust_t'> </a></td>
					<td align="center" style="width:180px;"><a id='lblComp_t'> </a></td>
					<td align="center" style="width:120px;"><a id='lblTol_t'> </a></td>
					<td align="center" style="width:70px;"><a id='lblBottom_t'> </a></td>
					<td align="center" style="width:70px;"><a id='lblFoot_t'> </a></td>
				</tr>
				<tr>
					<td>
						<input id="btnMinut..*"  type="button" style="font-size: medium; font-weight: bold;" value="-"/>
						<input class="txt" id="txtNoq..*" type="text" style="display: none;"/>
					</td>
					<td>
						<input class="txt c1" id="txtCustno..*" type="text" style="width:80%;float:left;"/>
						<input id="btnCustno..*" type="button" value="." style="float:left;width: 1%;"/>
					</td>
					<td>
						<input class="txt c1" id="txtComp..*" type="text" style="width:95%;float:left;"/>
					</td>
					<td>
						<input class="txt  num c1" id="txtBtol..*" type="text" style="width: 40%;"/>
						<a style="float: left;">~</a>
						<input class="txt  num c1" id="txtEtol..*" type="text" style="width: 40%;"/>
					</td>
					<td><input class="txt num c1" id="txtBottom..*" type="text"  style="width: 90%;"/></td>
					<td><input class="txt num c1" id="txtFoot..*" type="text"  style="width: 90%;"/></td>
				</tr>
			</table>
		</div>
	</body>
</html>
