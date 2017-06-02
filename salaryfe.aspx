<%@ Page Language="C#" Debug="true"%>
    <script language="c#" runat="server">  
		protected void Page_Load(object sender, EventArgs e)
		{
		    jwcf wcf = new jwcf();
			wcf.q_content("salaryfe", " typea='業務'");
		    wcf.q_content("salaryfes", " left( $r_userno,1)!='B' or ( sno=$r_userno or $r_rank >= 8 )");
		    
		}
	</script>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
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
            q_tables = 's';
            var q_name = "salaryfe";
            var decbbs = [];
            var decbbm = [];
            var q_readonly = ['txtNoa','txtWorker','txtWorker2','txtBase'
            	,'txtPlus','txtMinus','txtTransfer','txtCash','txtTotal'
            	,'p01','p02','p03','p04','p05','p06','p07','p08','p09'
            	,'p10','p11','p12','p13','p14','p15','p16','p17','p18'
            	,'m01','m02','m03','m04'];
            var q_readonlys = ['txtNoq','txtTotal'];
            var bbmNum = [['txtBase',10,0,1],['txtTotal',10,0,1]
            	,['txtP01',10,0,1],['txtP02',10,0,1],['txtP03',10,0,1],['txtP04',10,0,1],['txtP05',10,0,1]
            	,['txtP06',10,0,1],['txtP07',10,0,1],['txtP08',10,0,1],['txtP09',10,0,1],['txtP10',10,0,1]
            	,['txtP11',10,0,1]];
            var bbsNum = [['txtBase',10,0,1],['txtTotal',10,0,1]
            	,['txtP01',10,0,1],['txtP02',10,0,1],['txtP03',10,0,1],['txtP04',10,0,1],['txtP05',10,0,1]
            	,['txtP06',10,0,1],['txtP07',10,0,1],['txtP08',10,0,1],['txtP09',10,0,1],['txtP10',10,0,1]
            	,['txtP11',10,0,1]];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            aPop = new Array(['txtSssno_', 'btnSss_', 'sss', 'noa,namea', 'txtSssno_,txtSss_', 'sss_b.aspx']);
            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                q_brwCount();
				q_gt(q_name, q_content, q_sqlCount, 1, 0, '');

            });

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(1);
            }

            function sum() {
            	if(!(q_cur=='1' || q_cur=='2')){
            		return;
            	}
            	var base=0,total=0
            		,p01=0,p02=0,p03=0,p04=0,p05=0,p06=0,p07=0,p08=0,p09=0
            		,p10=0,p11=0;
            	for(var i=0;i<q_bbsCount;i++){
            		base += q_float('txtBase_'+i);
            		p01 += q_float('txtP01_'+i);
            		p02 += q_float('txtP02_'+i);
            		p03 += q_float('txtP03_'+i);
            		p04 += q_float('txtP04_'+i);
            		p05 += q_float('txtP05_'+i);
            		p06 += q_float('txtP06_'+i);
            		p07 += q_float('txtP07_'+i);
            		p08 += q_float('txtP08_'+i);
            		p09 += q_float('txtP09_'+i);
            		p10 += q_float('txtP10_'+i);
            		p11 += q_float('txtP11_'+i);
            		$('#txtTotal_'+i).val(q_float('txtBase_'+i)
            			+q_float('txtP01_'+i)+q_float('txtP02_'+i)+q_float('txtP03_'+i)+q_float('txtP04_'+i)
            			+q_float('txtP05_'+i)+q_float('txtP06_'+i)+q_float('txtP07_'+i)+q_float('txtP08_'+i)
            			+q_float('txtP09_'+i)+q_float('txtP10_'+i)+q_float('txtP11_'+i));
            		total += q_float('txtTotal_'+i);
            	}	
            	$('#txtBase').val(FormatNumber(base));
            	$('#txtP01').val(FormatNumber(p01));
            	$('#txtP02').val(FormatNumber(p02));
            	$('#txtP03').val(FormatNumber(p03));
            	$('#txtP04').val(FormatNumber(p04));
            	$('#txtP05').val(FormatNumber(p05));
            	$('#txtP06').val(FormatNumber(p06));
            	$('#txtP07').val(FormatNumber(p07));
            	$('#txtP08').val(FormatNumber(p08));
            	$('#txtP09').val(FormatNumber(p09));
            	$('#txtP10').val(FormatNumber(p10));
            	$('#txtP11').val(FormatNumber(p11));
              	$('#txtTotal').val(FormatNumber(total));
            }

            function mainPost() {
                q_getFormat();
                bbmMask = [['txtMon', r_picm]];
                q_mask(bbmMask);
                
                $('#btnImport').click(function(e){
                	var t_mon = $.trim($('#txtMon').val());
                	if(t_mon.length==0){
                		alert('請輸入月份！');
                		return;
                	}
                	q_func('qtxt.query.import', 'salaryfe.txt,import,'+t_mon);
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
            function q_gtPost(t_name) {
                switch (t_name) {

                    case q_name:
                    	document.title= '員工薪資';
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                    default:
                     	break;
                }
            }

            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
            }
            
            function btnOk() {
				$('#txtTypea').val('業務');
                sum();
                if (q_cur == 1)
                    $('#txtWorker').val(r_name);
                if (q_cur == 2)
                    $('#txtWorker2').val(r_name);
                
				var s1 = $('#txtNoa').val();
                if (s1.length == 0 || s1 == "AUTO")
                    q_gtnoa(q_name, replaceAll($('#txtMon').val(), '/', ''));
                else
                    wrServer(s1);
            }
            function q_funcPost(t_func, result) {
                switch(t_func) {
                	case 'qtxt.query.import':
						var as = _q_appendData("tmp0", "", true);
                        if (as[0] != undefined) {
                        	for(var i=0;i<q_bbsCount;i++){
                        		$('#btnMinus_'+i).click();
                        	}
                        	q_gridAddRow(bbsHtm, 'tbbs', 'txtSssno,txtSss,txtBase,txtP01,txtP02,txtP03,txtP04,txtP05,txtP06,txtP07,txtP08,txtP09,txtP10,txtP11,txtTotal,txtC01,txtC02,txtC03,txtC04,txtD01,txtD02,txtD03'
                        	, as.length, as, 'sssno,sss,m01,m02,m03,m04,m05,m06,m07,m08,m09,m10,m11,m12,total,n01,n02,c01,c02,b01,b02,b03', '','');
                        	sum();
                        }else{
                    		alert('無資料。');
                        	return;
                        }
						break;
                    default:
                       break;
                }
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
                q_box('salaryfe_s.aspx', q_name + '_s', "500px", "500px", q_getMsg("popSeek"));
            }

            function bbsAssign() {
                for (var i = 0; i < (q_bbsCount == 0 ? 1 : q_bbsCount); i++) {
                	$('#lblNo_'+i).text(i+1);
                    if ($('#btnMinus_' + i).hasClass('isAssign'))
						continue;
					$('#txtSssno_' + i).bind('contextmenu', function(e) {
                        /*滑鼠右鍵*/
                        e.preventDefault();
                        var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                        $('#btnSss_' + n).click();
                    });
                    $('#txtBase_'+i).change(function(e){sum();});
                    $('#txtP01_'+i).change(function(e){sum();});
                    $('#txtP02_'+i).change(function(e){sum();});
                    $('#txtP03_'+i).change(function(e){sum();});
                    $('#txtP04_'+i).change(function(e){sum();});
                    $('#txtP05_'+i).change(function(e){sum();});
                    $('#txtP06_'+i).change(function(e){sum();});
                    $('#txtP07_'+i).change(function(e){sum();});
                    $('#txtP08_'+i).change(function(e){sum();});
                    $('#txtP09_'+i).change(function(e){sum();});
                    $('#txtP10_'+i).change(function(e){sum();});
                    $('#txtP11_'+i).change(function(e){sum();});
                	$('#txtTotal_'+i).change(function(e){sum();});
                }
                _bbsAssign();
            }

            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtDatea').val(q_date());
                $('#txtDatea').focus();
            }
			var guid = (function() {
				function s4() {return Math.floor((1 + Math.random()) * 0x10000).toString(16).substring(1);}
				return function() {return s4() + s4() + '-' + s4() + '-' + s4() + '-' +s4() + '-' + s4() + s4() + s4();};
			})();
            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                if (q_chkClose())
					return;
                _btnModi();
            }

            function btnPrint() {
				q_box("z_salaryfe.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + JSON.stringify({noa:trim($('#txtNoa').val())}) + ";" + r_accy + "_" + r_cno, 'salaryfe', "95%", "95%", m_print);
			}

            function wrServer(key_value) {
                var i;
                $('#txtNoa').val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (!as['sssno']) {
                    as[bbsKey[1]] = '';
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
                if (t_para) {
                	$('#btnImport').attr('disabled','disabled');
                } else {	
                	$('#btnImport').removeAttr('disabled');
            	}
                /*if (t_para) {
                    $('#txtDatea').datepicker('destroy');
                } else {	
                    $('#txtDatea').datepicker();
                }*/
            }

            function btnMinus(id) {
                _btnMinus(id);
                sum();
            }

            function btnPlus(org_htm, dest_tag, afield) {
                _btnPlus(org_htm, dest_tag, afield);
                if (q_tables == 's')
                    bbsAssign();
            }

            function q_appendData(t_Table) {
                dataErr = !_q_appendData(t_Table);
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
            	if (q_chkClose())
					return;
                _btnDele();
            }

            function btnCancel() {
                _btnCancel();
            }

            function q_popPost(s1) {
                switch (s1) {
                    default:
                        break;
                }
            }

            function FormatNumber(n) {
                var xx = "";
                if (n < 0) {
                    n = Math.abs(n);
                    xx = "-";
                }
                n += "";
                var arr = n.split(".");
                var re = /(\d{1,3})(?=(\d{3})+$)/g;
                return xx + arr[0].replace(re, "$1,") + (arr.length == 2 ? "." + arr[1] : "");
            }

        </script>
        <style type="text/css">
			#dmain {
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
				width: 10%;
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
			.dbbs {
                width: 2000px;
            }
            .tbbs a {
                font-size: medium;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            .num {
                text-align: right;
            }
            select {
                font-size: medium;
            }
		</style>
    </head>
    <body>
        <!--#include file="../inc/toolbar.inc"-->
        <div id='dmain' style="overflow:hidden;width: 1000px;">
            <div class="dview" id="dview">
                <table class="tview" id="tview" >
                    <tr>
                        <td align="center" style="width:5%"><a id='vewChk'> </a></td>
                        <td style="display:none;">noa</td>
                        <td align="center" style="width:20%"><a id='vewMon'>月份</a></td>
                        <td align="center" style="width:20%"><a id='vewTotal'>薪資</a></td>
                    </tr>
                    <tr>
                        <td><input id="chkBrow.*" type="checkbox" style=''/></td>
                        <td style="display:none;" id='noa'>~noa</td>
                        <td align="center" id='mon'>~mon</td>
                        <td align="center" id='total'>~total</td>
                    </tr>
                </table>
            </div>
            <div class='dbbm'>
                <table class="tbbm" id="tbbm">
                	<tr style="height:1px;">
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td class="tdZ"> </td>
					</tr>
                    <tr>
                        <td><span> </span><a id='lblNoa' class="lbl">電腦編號</a></td>
                        <td>
                        	<input id="txtNoa" type="text" class="txt c1"/>
                        	<input id="txtTypea" type="text" style="display:none;"/>
                    	</td>
                        <td><span> </span><a id='lblMon' class="lbl">月份</a></td>
                        <td><input id="txtMon" type="text" class="txt c1"/></td>
                        <td><span> </span><a id='lblBase' class="lbl">本薪</a></td>
                        <td><input id="txtBase" type="text" class="txt num c1"/></td>
                    </tr>
                    <tr>
                    	<td><span> </span><a id='lblP01' class="lbl">全勤</a></td>
                        <td><input id="txtP01" type="text" class="txt num c1"/></td>
                        <td><span> </span><a id='lblP02' class="lbl">無遲到</a></td>
                        <td><input id="txtP02" type="text" class="txt num c1"/></td>
                        <td><span> </span><a id='lblP03' class="lbl">個人獎金</a></td>
                        <td><input id="txtP03" type="text" class="txt num c1"/></td>
                    </tr>
                    <tr>
                    	<td><span> </span><a id='lblP04' class="lbl">會議出勤</a></td>
                        <td><input id="txtP04" type="text" class="txt num c1"/></td>
                        <td><span> </span><a id='lblP05' class="lbl">成交獎金</a></td>
                        <td><input id="txtP05" type="text" class="txt num c1"/></td>
                        <td><span> </span><a id='lblP06' class="lbl">收現獎金</a></td>
                        <td><input id="txtP06" type="text" class="txt num c1"/></td>
                    </tr>
                    <tr>
                    	<td><span> </span><a id='lblP07' class="lbl">早收獎金</a></td>
                        <td><input id="txtP07" type="text" class="txt num c1"/></td>
                        <td><span> </span><a id='lblP08' class="lbl">簽約獎金</a></td>
                        <td><input id="txtP08" type="text" class="txt num c1"/></td>
                        <td><span> </span><a id='lblP09' class="lbl">職等級</a></td>
                        <td><input id="txtP09" type="text" class="txt num c1"/></td>
                    </tr>
                    <tr>
                    	<td><span> </span><a id='lblP10' class="lbl">報價獎金</a></td>
                        <td><input id="txtP10" type="text" class="txt num c1"/></td>
                        <td><span> </span><a id='lblP11' class="lbl">親恰拜訪獎金</a></td>
                        <td><input id="txtP11" type="text" class="txt num c1"/></td>
                        <td><span> </span><a id='lblTotal' class="lbl">總計</a></td>
                        <td><input id="txtTotal" type="text" class="txt num c1"/></td>
                    </tr>
                    <tr>
						<td><span> </span><a id='lblMemo' class="lbl">備註</a></td>
						<td colspan="5"><textarea id="txtMemo" rows="3" class="txt c1"> </textarea></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWorker' class="lbl">製單人</a></td>
						<td><input id="txtWorker"  type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblWorker2' class="lbl">修改人</a></td>
						<td><input id="txtWorker2"  type="text" class="txt c1"/></td>
						<td> </td>
						<td><input type="button" id="btnImport" value="匯入"/></td>
					</tr>
                </table>
            </div>
        </div>
        <div class='dbbs'>
            <table id="tbbs" class='tbbs' style=' text-align:center'>
                <tr style='color:white; background:#003366;' >
                    <td align="center" style="width:1%;">
                        <input class="btn" id="btnPlus" type="button" value='＋' style="font-weight: bold;" />
                    </td>
		
                    <td align="center" style="width:20px;"> </td>
                    <td align="center" style="width:200px;"><a>業務</a></td>
                    <td align="center" style="width:120px;"><a>本薪</a></td>
                    <td align="center" style="width:120px;"><a>全勤 </a></td>
                    <td align="center" style="width:120px;"><a>無遲到</a></td>
                    <td align="center" style="width:120px;"><a>個人獎金</a></td>
                    <td align="center" style="width:120px;"><a>會議出勤</a></td>
                    <td align="center" style="width:120px;"><a>成交獎金</a></td>
                    <td align="center" style="width:120px;"><a>收現獎金</a></td>
                    <td align="center" style="width:120px;"><a>早收獎金</a></td>
                    <td align="center" style="width:120px;"><a>簽約獎金</a></td>
                    <td align="center" style="width:120px;"><a>職等級</a></td>
                    <td align="center" style="width:120px;"><a>報價獎金</a></td>
                    <td align="center" style="width:120px;"><a>親恰拜訪<br>獎金</a></td>
           			<td align="center" style="width:120px;"><a>實領</a></td>
           			
           			<td align="center" style="width:120px;"><a>營業額</a></td>
           			<td align="center" style="width:80px;"><a>毛利額</a></td>
           			<td align="center" style="width:80px;"><a>毛利目標</a></td>
           			<td align="center" style="width:80px;"><a>未達標扣項</a></td>
           			
           			<td align="center" style="width:80px;"><a>成交<br>件數</a></td>
           			<td align="center" style="width:80px;"><a>增加<br>件數</a></td>
           			<td align="center" style="width:80px;"><a>下月<br>件數</a></td>
                </tr>
                <tr style='background:#cad3ff;'>
                    <td>
                        <input class="btn" id="btnMinus.*" type="button" value='－' style=" font-weight: bold;" />
                   		<input id="txtNoq.*" type="text" style="display:none;"/> 
                    </td>
                    <td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
                    <td>
                    	<input id="txtSssno.*" type="text" class="txt" style="float:left;width:40%;"/>
                        <input id="txtSss.*" type="text" class="txt" style="float:left;width:50%;"/>
                        <input id='btnSss.*' type="button" style="display:none;"/>
                    </td>
                    <td> <input id="txtBase.*" type="text" class="txt num" style="width:95%;"/></td>
                    <td> <input id="txtP01.*" type="text" class="txt num" style="width:95%;"/></td>
                    <td> <input id="txtP02.*" type="text" class="txt num" style="width:95%;"/></td>
                    <td> <input id="txtP03.*" type="text" class="txt num" style="width:95%;"/></td>
                    <td> <input id="txtP04.*" type="text" class="txt num" style="width:95%;"/></td>
                    <td> <input id="txtP05.*" type="text" class="txt num" style="width:95%;"/></td>
                    <td> <input id="txtP06.*" type="text" class="txt num" style="width:95%;"/></td>
                    <td> <input id="txtP07.*" type="text" class="txt num" style="width:95%;"/></td>
                    <td> <input id="txtP08.*" type="text" class="txt num" style="width:95%;"/></td>
                    <td> <input id="txtP09.*" type="text" class="txt num" style="width:95%;"/></td>
                    <td> <input id="txtP10.*" type="text" class="txt num" style="width:95%;"/></td>
                    <td> <input id="txtP11.*" type="text" class="txt num" style="width:95%;"/></td>
                    <td> <input id="txtTotal.*" type="text" class="txt num" style="width:95%;"/></td>
                    
                    <td> <input id="txtC01.*" type="text" class="txt num" style="width:95%;"/></td>
                    <td> <input id="txtC02.*" type="text" class="txt num" style="width:95%;"/></td>
                    <td> <input id="txtC03.*" type="text" class="txt num" style="width:95%;"/></td>
                    <td> <input id="txtC04.*" type="text" class="txt num" style="width:95%;"/></td>
                    
                    <td> <input id="txtD01.*" type="text" class="txt num" style="width:95%;"/></td>
                    <td> <input id="txtD02.*" type="text" class="txt num" style="width:95%;"/></td>
                    <td> <input id="txtD03.*" type="text" class="txt num" style="width:95%;"/></td>
                </tr>
            </table>
        </div>
        <input id="q_sys" type="hidden" />
    </body>
</html>