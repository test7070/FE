<%@ Import Namespace="Newtonsoft.Json" %>
<%@ Page Language="C#" Debug="true"%>
    <script language="c#" runat="server">     
        
        string connectionString = "Data Source=127.0.0.1,1799;Persist Security Info=True;User ID=sa;Password=artsql963;Database=";

        public class ParaIn
        {
            public string db = "st", action = "", table = "";
            //originImg優先使用，不然就依picno去 TABLE img 中抓資料
            public string originImg = "";
            public string picno = "";
            public string orgpara = "";//imgfe參數
            public string para = "";
            public string noa = "", noq = "";
        }
        public class Result
        {
            public int status = 0;
            public string filename = "";
            public string message = "";
        }

        public void Page_Load()
        {
            //圖檔檔案過大，須使用POST
            //POST
            System.Text.Encoding encoding = System.Text.Encoding.UTF8;
            Response.ContentEncoding = encoding;
            int formSize = Request.TotalBytes;
            byte[] formData = Request.BinaryRead(formSize);
            System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
            ParaIn item = serializer.Deserialize<ParaIn>(encoding.GetString(formData));
            //ParaIn item = serializer.Deserialize<ParaIn>(@"{""db"":""st"",""action"":""img"",""table"":""img"",""originImg"":""data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAASwAAABkCAYAAAA8AQ3AAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAI1SURBVHhe7djbattAFEBRX0L+/3/j2M0xnpKWUkl96oa1QGjix+GwNZnz48sJIODyegP89wQLyBAsIEOwgAzBAjIEC8gQLCBDsIAMwQIyBAvIECwgQ7CADMECMgQLyBAsIEOwgAzBAjIEC8gQLCBDsIAMwQIyBAvIECwgQ7CADMECMgQLyBAsIEOwgAzBAjIEC8gQLCBDsIAMwQIyBAvIECwgQ7CADMECMgQLyBAsIEOwgAzBAjIEC8gQLCBDsIAMwQIyBAvIECwgQ7CADMECMgQLyBAsIEOwgAzBAjIEC8gQLCBDsDY8Ho/XCo5b8/P5+fl8j/ltPRwjWBvO5/NrdTrd7/fX6tc1bLler8/37XZ7ztR6OEawdlhfwsvl8vNLOWvRYsuK0szKzNHb29tzhj4+Pp6/c8z5axOdS3earfr9q2j72DIzsj5w814mXOvkxT6CteH79kysZui+R8uxnr+Z+ZkZWXGak9VES6j+jWAdNEf62bIVLtvHlrm3+lOgnLCOc4e1YYZqorTCNH+7u2KvCdI8Mz9zupp4jVmL1XFOWDvMFq1/B9/f35/RcunOXjM/a4bGzM33uyz2EywgQ+aBDMECMgQLyBAsIEOwgAzBAjIEC8gQLCBDsIAMwQIyBAvIECwgQ7CADMECMgQLyBAsIEOwgAzBAjIEC8gQLCBDsIAMwQIyBAvIECwgQ7CADMECMgQLyBAsIEOwgAzBAjIEC8gQLCBDsIAMwQIyBAuIOJ1+AGhApUiVxEknAAAAAElFTkSuQmCC"",""picno"":""00"",""orgpara"":""[{\""key\"":\""A\"",\""top\"":0,\""left\"":100,\""fontsize\"":\""50\""}]"",""para"":""""}");
            //ParaIn item = serializer.Deserialize<ParaIn>(@"{""db"":""st"",""action"":""img"",""table"":""workj"",""originImg"":"""",""picno"":""10"",""orgpara"":"""",""para"":""{\""A\"":\""1\"",\""B\"":\""0\"",\""C\"":\""0\"",\""D\"":\""0\"",\""E\"":\""0\"",\""F\"":\""0\""}""}");
            connectionString += item.db;            
            // action = "tmp"   新增、修改下的預覽圖，只會產生一個圖片。檔案存在tmp資料夾底下，tmp資料夾檔案可隨時刪除
            // action = "img"   存檔後產生檔案，供imgfe、wrokj、xls使用。檔案存在img資料夾底下，資料不可隨意刪除
            string result = "";
            switch (item.table)
            {
                case "img":
                    result = serializer.Serialize(genImage(item));
                    break;
                case "workj":
                    result = serializer.Serialize(genImage2(item));
                    break; 
            }
            Response.Write(result);
            Response.End();
        }
        public Result genImage(ParaIn item)
        {
            //imgfe
            string filePath = item.action == "img" ? @"C:\inetpub\wwwroot\htm\htm\img\" : @"C:\inetpub\wwwroot\htm\htm\tmp\";
            //para為空值，代表是要產生imgfe用的預覽圖
            Result result = new Result();
            //前端參數
            Newtonsoft.Json.Linq.JObject jo1 = Newtonsoft.Json.JsonConvert.DeserializeObject<Newtonsoft.Json.Linq.JObject>(item.para);
            //圖片參數
            Newtonsoft.Json.Linq.JArray ja = Newtonsoft.Json.JsonConvert.DeserializeObject<Newtonsoft.Json.Linq.JArray>(item.orgpara);
            Newtonsoft.Json.Linq.JObject[] jo2 = new Newtonsoft.Json.Linq.JObject[ja.Count];
            for (int i = 0; i < ja.Count; i++)
            {
                jo2[i] = Newtonsoft.Json.JsonConvert.DeserializeObject<Newtonsoft.Json.Linq.JObject>(ja[i].ToString());
            }

            //圖片
            var bytes = Convert.FromBase64String(item.originImg.Split(',')[1]);
            System.Drawing.Bitmap bmp;
            using (var ms = new System.IO.MemoryStream(bytes))
            {
                bmp = new System.Drawing.Bitmap(ms);
            }
            System.Drawing.Graphics g = System.Drawing.Graphics.FromImage(bmp);
            //畫圖
            float top, left;
            string val = "";
            int fontsize;

            System.Drawing.SolidBrush drawBrush = new System.Drawing.SolidBrush(System.Drawing.Color.Gray);
            System.Drawing.Font drawFont = new System.Drawing.Font("Arial", 15);
            for (int i = 0; i < jo2.Length; i++)
            {
                try
                {
                    top = (float)jo2[i]["top"];
                    left = (float)jo2[i]["left"];
                    fontsize = Int32.Parse((string)jo2[i]["fontsize"]);


                    if (jo1 == null)
                    {
                        val = (string)jo2[i]["key"];
                        drawBrush = new System.Drawing.SolidBrush(System.Drawing.Color.Red);
                    }
                    else
                    {
                        val = (jo1.Property((string)jo2[i]["key"]).Value).ToString();
                        drawBrush = new System.Drawing.SolidBrush(System.Drawing.Color.Black);
                    }
                    // Create string to draw.
                    String drawString = val;
                    // Create font and brush.
                    drawFont = new System.Drawing.Font("Arial", fontsize);

                    // Create point for upper-left corner of drawing.

                    // Draw string to screen.
                    g.DrawString(drawString, drawFont, drawBrush, left, top);
                }
                catch (Exception e) { }

            }
            System.IO.MemoryStream stream = new System.IO.MemoryStream();
            bmp.Save(stream, System.Drawing.Imaging.ImageFormat.Png);
            //---------------------------------------------------------------
            string uFileName = item.action == "img" ? item.table + item.picno + ".png" : string.Format(@"{0}.png", Guid.NewGuid());

            if (System.IO.Directory.Exists(filePath))
            {
                //資料夾存在
            }
            else
            {
                //新增資料夾
                System.IO.Directory.CreateDirectory(filePath);
            }
            System.IO.FileStream pFileStream = null;
            try
            {
                pFileStream = new System.IO.FileStream(filePath + uFileName, System.IO.FileMode.OpenOrCreate);
                pFileStream.Write(stream.ToArray(), 0, stream.ToArray().Length);
                result.status = 1;
            }
            catch (Exception e)
            {
                uFileName = "";
                result.status = -1;
                result.message = e.Message;
            }
            finally
            {
                if (pFileStream != null)
                    pFileStream.Close();
            }
            stream.Close();
            result.filename = uFileName;

            return result;
        }
        public Result genImage2(ParaIn item)
        {
            Result result = new Result();
            //縮放成  150 X 50
            int tWidth = 150;
            int tHeight = 50;
            
            string filePath = item.action == "img" ? @"C:\inetpub\wwwroot\htm\htm\img\" : @"C:\inetpub\wwwroot\htm\htm\tmp\";

            System.Data.DataTable dt = new System.Data.DataTable();
            using (System.Data.SqlClient.SqlConnection connSource = new System.Data.SqlClient.SqlConnection(connectionString))
            {
                System.Data.SqlClient.SqlDataAdapter adapter = new System.Data.SqlClient.SqlDataAdapter();
                connSource.Open();
                string queryString = @"select para,org from img where noa=@picno";
                System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(queryString, connSource);
                cmd.Parameters.AddWithValue("@picno", item.picno);
                adapter.SelectCommand = cmd;
                adapter.Fill(dt);
                connSource.Close();
            }
            foreach (System.Data.DataRow r in dt.Rows)
            {
                item.orgpara = System.DBNull.Value.Equals(r.ItemArray[0]) ? "" : (System.String)r.ItemArray[0];
                item.originImg = System.DBNull.Value.Equals(r.ItemArray[1]) ? "" : (System.String)r.ItemArray[1];
            }
            //前端參數
            Newtonsoft.Json.Linq.JObject jo1 = Newtonsoft.Json.JsonConvert.DeserializeObject<Newtonsoft.Json.Linq.JObject>(item.para);
            //圖片參數
            Newtonsoft.Json.Linq.JArray ja = Newtonsoft.Json.JsonConvert.DeserializeObject<Newtonsoft.Json.Linq.JArray>(item.orgpara);
            Newtonsoft.Json.Linq.JObject[] jo2 = new Newtonsoft.Json.Linq.JObject[ja.Count];
            for (int i = 0; i < ja.Count; i++)
            {
                jo2[i] = Newtonsoft.Json.JsonConvert.DeserializeObject<Newtonsoft.Json.Linq.JObject>(ja[i].ToString());
            }

            //圖片
            var bytes = Convert.FromBase64String(item.originImg.Split(',')[1]);
            System.Drawing.Bitmap bmp;
            using (var ms = new System.IO.MemoryStream(bytes))
            {
                bmp = new System.Drawing.Bitmap(ms);
            }
            System.Drawing.Graphics g = System.Drawing.Graphics.FromImage(bmp);
            
            //畫圖
            float top, left;
            string val = "";
            int fontsize;

            System.Drawing.SolidBrush drawBrush = new System.Drawing.SolidBrush(System.Drawing.Color.Gray);
            System.Drawing.Font drawFont = new System.Drawing.Font("Arial", 15);
            for (int i = 0; i < jo2.Length; i++)
            {
                try
                {
                    top = (float)jo2[i]["top"];
                    left = (float)jo2[i]["left"];
                    fontsize = Int32.Parse((string)jo2[i]["fontsize"]);


                    if (jo1 == null)
                    {
                        val = (string)jo2[i]["key"];
                        drawBrush = new System.Drawing.SolidBrush(System.Drawing.Color.Red);
                    }
                    else
                    {
                        val = (jo1.Property((string)jo2[i]["key"]).Value).ToString();
                        drawBrush = new System.Drawing.SolidBrush(System.Drawing.Color.Black);
                    }
                    // Create string to draw.
                    String drawString = val;
                    // Create font and brush.
                    drawFont = new System.Drawing.Font("Arial", fontsize);

                    // Create point for upper-left corner of drawing.

                    // Draw string to screen.
                    g.DrawString(drawString, drawFont, drawBrush, left, top);
                }
                catch (Exception e) { }

            }
            System.Drawing.Bitmap tmpBmp = new System.Drawing.Bitmap(tWidth, tHeight);
            System.Drawing.Graphics tmpG = System.Drawing.Graphics.FromImage(tmpBmp);
            try
            {
                tmpG.DrawImage(bmp
                        , new System.Drawing.Rectangle(0, 0, tWidth, tHeight)
                        , new System.Drawing.Rectangle(0, 0, bmp.Width, bmp.Height)
                        , System.Drawing.GraphicsUnit.Pixel);
            }
            catch
            {
            }
            System.IO.MemoryStream stream = new System.IO.MemoryStream();
            tmpBmp.Save(stream, System.Drawing.Imaging.ImageFormat.Png);
            //---------------------------------------------------------------
            string uFileName = item.action == "img" ? item.table + item.noa+"-"+item.noq + ".png" : string.Format(@"{0}.png", Guid.NewGuid());

            if (System.IO.Directory.Exists(filePath))
            {
                //資料夾存在
            }
            else
            {
                //新增資料夾
                System.IO.Directory.CreateDirectory(filePath);
            }
            System.IO.FileStream pFileStream = null;
            try
            {
                pFileStream = new System.IO.FileStream(filePath + uFileName, System.IO.FileMode.OpenOrCreate);
                pFileStream.Write(stream.ToArray(), 0, stream.ToArray().Length);
                result.status = 1;
            }
            catch (Exception e)
            {
                uFileName = "";
                result.status = -1;
                result.message = e.Message;
            }
            finally
            {
                if (pFileStream != null)
                    pFileStream.Close();
            }
            stream.Close();
            result.filename = uFileName;

            return result;
        }
    </script>
