<%-- 
    Document   : index
    Created on : Aug 15, 2018, 9:26:32 AM
    Author     : raharjo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
   <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Machine Learning 101</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!--<link rel="stylesheet" href="css/bootstrap.min.css"/>-->  
        <link rel="stylesheet" type="text/css" href="css/file-upload.css" />  
        <link rel="stylesheet" type="text/css" href="css/checkbox.css" /> 
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css" integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ" crossorigin="anonymous">
        
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
        
        <!--<script src="js/bootstrap.min.js"></script>--> 
        <!--<script src="js/jquery.js"></script>-->
        <script src="js/file-upload.js"></script> 
        <script type="text/javascript">
                   $(document).ready(function() {
                       $('.file-upload').file_upload();
                   });
        </script>
   </head>
   
   
    <body>
        <div class="container">
            <h2>Topdown Supervised Learning 101</h2>
            
            <div class="card">
                <h4 class="card-header">Input Data</h4>
                
            <div class="card-body">
            <% 
                String msg = ((String)request.getAttribute("rdeminfo") != null) ? (String)request.getAttribute("rdeminfo") : "null";
                if(msg.equals("null")){
            %>                
                <h4><i>Unable to read your file</i></h4>
                <form action="uploads" method="post" enctype="multipart/form-data">
                   <div class="input-group mb-3">
                    <div class="input-group-prepend">
                      <span class="input-group-text">train data</span>
                    </div>
                    <div class="custom-file">
                    <label class="file-upload custom-file-label" >Choose file<input type="file" name="train" class="custom-file-input"></label>
                    </div>
                  </div>

                  <div class="input-group mb-3">
                    <div class="input-group-prepend">
                      <span class="input-group-text">test data</span>
                    </div>
                    <div class="custom-file">
                    <label class="file-upload custom-file-label" >Choose file<input type="file" name="test" class="custom-file-input"></label>
                    </div>
                  </div>

                <button type="submit" class="btn btn-info">
                        <span class="glyphicon glyphicon-search"></span> Upload File
                </button>
                </form>
            <%
                }else{
                    String[] content = msg.split(":");
                    if(content[0].equals("1")){
                        String msg2 = ((String)request.getAttribute("dataset") != null) ? (String)request.getAttribute("dataset") : "null";
                        if(msg2.equals("null"))
                            out.println("<h4><i>Unable to read the data</i></h4>");
                        else{
                    %>
                    <div class="row">
                        <div class="col-md-6">
                        <%
                                   String[] content2 = msg2.split("--");
                                   out.println("<b>Train:</b><br/>" + content2[1]);%>
                        </div>
                        <div class="col-md-6">
                                   <%
                                   out.println("<b>Test:</b><br/>" + content2[3]);
                         %>            
                        </div>
                    </div><%
                            }
                      %>
            </div>
            </div>
                        <br/>
                        <div class="row btn-toolbar">
                            <input type="button" id="select" onclick='selectAll()' class="btn btn-info col-md-2" value="Select All"/>
                             
                            <input type="button" id="deselect" onclick='deselectAll()' class="btn btn-warning col-md-2" value="Deselect All"/>
                	</div>
                        <script type="text/javascript">
                            var item=document.getElementsByName('algo');
				for(var i=0; i<item.length; i++){
					if(item[i].type=='checkbox')
						item[i].checked=true;
				}
            
                            function selectAll(){
				var items=document.getElementsByName('algo');
				for(var i=0; i<items.length; i++){
					if(items[i].type=='checkbox')
						items[i].checked=true;
				}
                                document.getElementById("select").classList.remove('btn-info');
                                document.getElementById("select").classList.add('btn-block');
                                document.getElementById("deselect").classList.remove('btn-block');
                                document.getElementById("deselect").classList.add('btn-warning');
                            }

                            function deselectAll(){
                                    var items=document.getElementsByName('algo');
                                    for(var i=0; i<items.length; i++){
                                            if(items[i].type=='checkbox')
                                                    items[i].checked=false;
                                    }
                                document.getElementById("select").classList.remove('btn-block');
                                document.getElementById("select").classList.add('btn-info');
                                document.getElementById("deselect").classList.remove('btn-warning');
                                document.getElementById("deselect").classList.add('btn-block');
                            }	
                        </script>
                        <script>
                        function myFunction(y) {
                            var x = document.getElementById("option"+y); 
                            x.style.display = (x.style.display  == "none") ? "block":"none";
                        }
                        </script>

                        <form action="Classify" method="POST">
                           <input type="hidden" name="train" value="<% out.print(content[1]); %>"/>
                           <input type="hidden" name="test" value="<% out.print(content[2]); %>"/>
                           <input type="hidden" name="msg2" value="<% out.print(msg2); %>"/>
                           
                           <div class="row">
                               <div class="col-md-6">
                                <h3>Lazy</h3>
                                <table class="table table-borderless table-sm">
                                    <tr>
                                       <td class="col-1" ><label class="switch"><input type="checkbox" checked="true" name="algo"  value="0"><span class="slider round"></span></label></td>
                                       <td><text class="btn-link" onclick="myFunction(0)">IBk</text><br/>
                                           <input type="text" style="display:none;" class="form-control" name="option0" id="option0">
                                           </td>
                                   </tr>
                                   <tr>
                                       <td class="col-1" ><label class="switch"><input type="checkbox" checked="true" name="algo"  value="1"><span class="slider round"></span></label></td>
                                       <td><text class="btn-link" onclick="myFunction(1)">K-Star</text><br/>
                                           <input type="text" style="display:none;" class="form-control" name="option1" id="option1">
                                           </td>
                                   </tr>
                                   <tr>
                                       <td class="col-1" ><label class="switch"><input type="checkbox" checked="true" name="algo"  value="2"><span class="slider round"></span></label></td>
                                       <td><text class="btn-link" onclick="myFunction(2)">Locally Weighted Learning</text><br/>
                                           <input type="text" style="display:none;" class="form-control" name="option2" id="option2">
                                           </td>
                                   </tr>
                                   <tr>
                                       <td class="col-1" ><label class="switch"><input type="checkbox" checked="true" name="algo"  value="3"><span class="slider round"></span></label></td>
                                       <td><text class="btn-link" onclick="myFunction(3)">Lazy Bayesian Rules</text><br/>
                                           <input type="text" style="display:none;" class="form-control" name="option3" id="option3">
                                           </td>
                                   </tr>
                                   </table>
                               </div>
                               <div class="col-md-6 ">
                                   <h3>Tree</h3>
                                   <table class="table table-borderless table-sm">
                                   <tr>
                                       <td class="col-1" ><label class="switch"><input type="checkbox" checked="true" name="algo"  value="4"><span class="slider round"></span></label></td>
                                       <td><text class="btn-link" onclick="myFunction(4)">J48</text><br/>
                                           <input type="text" style="display:none;" class="form-control" name="option4" id="option4">
                                       </td>
                                   </tr>
                                   <tr>
                                       <td ><label class="switch"><input type="checkbox" checked="true" name="algo"  value="5"><span class="slider round"></span></label></td>
                                       <td><text class="btn-link" onclick="myFunction(5)">Decision Stump</text><br/>
                                           <input type="text" style="display:none;" class="form-control" name="option5" id="option5">
                                           </td>
                                   </tr>
                                   <tr>
                                       <td ><label class="switch"><input type="checkbox" checked="true" name="algo"  value="6"><span class="slider round"></span></label></td>
                                       <td><text class="btn-link" onclick="myFunction(6)">Hoeffding Tree</text><br/>
                                           <input type="text" style="display:none;" class="form-control" name="option6" id="option6">
                                           </td>
                                   </tr>
                                   <tr>
                                       <td ><label class="switch"><input type="checkbox" checked="true" name="algo"  value="7"><span class="slider round"></span></label></td>
                                       <td><text class="btn-link" onclick="myFunction(7)">LMT</text><br/>
                                           <input type="text" style="display:none;" class="form-control" name="option7" id="option7">
                                           </td>
                                   </tr>
                                   <tr>
                                       <td ><label class="switch"><input type="checkbox" checked="true" name="algo"  value="8"><span class="slider round"></span></label></td>
                                       <td><text class="btn-link" onclick="myFunction(8)">REP Tree</text><br/>
                                           <input type="text" style="display:none;" class="form-control" name="option8" id="option8">
                                           </td>
                                   </tr>
                                   <tr>
                                       <td ><label class="switch"><input type="checkbox" checked="true" name="algo"  value="9"><span class="slider round"></span></label></td>
                                       <td><text class="btn-link" onclick="myFunction(9)">Simple Cart</text><br/>
                                           <input type="text" style="display:none;" class="form-control" name="option9" id="option9">
                                           </td>
                                   </tr>
                                   <tr>
                                       <td ><label class="switch"><input type="checkbox" checked="true" name="algo"  value="10"><span class="slider round"></span></label></td>
                                       <td><text class="btn-link" onclick="myFunction(10)">Best First Tree</text><br/>
                                           <input type="text" style="display:none;" class="form-control" name="option10" id="option10">
                                           </td>
                                   </tr>
                                   <tr>
                                       <td ><label class="switch"><input type="checkbox" checked="true" name="algo"  value="11"><span class="slider round"></span></label></td>
                                       <td><text class="btn-link" onclick="myFunction(11)">Random Forest</text><br/>
                                           <input type="text" style="display:none;" class="form-control" name="option11" id="option11">
                                           </td>
                                   </tr>
                                   </table>
                               </div>    
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                   <h3>Bayesian</h3>
                                   <table class="table table-borderless table-sm">
                                   <tr>
                                       <td class="col-1" ><label class="switch"><input type="checkbox" checked="true" name="algo"  value="12"><span class="slider round"></span></label></td>
                                       <td><text class="btn-link" onclick="myFunction(12)">BayesNet</text><br/>
                                           <input type="text" style="display:none;" class="form-control" name="option12" id="option12">
                                           </td>
                                   </tr>
                                   <tr>
                                       <td class="col-1" ><label class="switch"><input type="checkbox" checked="true" name="algo"  value="13"><span class="slider round"></span></label></td>
                                       <td><text class="btn-link" onclick="myFunction(13)">Naive Bayes Updateable</text><br/>
                                           <input type="text" style="display:none;" class="form-control" name="option13" id="option13">
                                           </td>
                                   </tr>
                                   <tr>
                                       <td class="col-1" ><label class="switch"><input type="checkbox" checked="true" name="algo"  value="14"><span class="slider round"></span></label></td>
                                       <td><text class="btn-link" onclick="myFunction(14)">Averaged 1 Dependence Estimator</text><br/>
                                           <input type="text" style="display:none;" class="form-control" name="option14" id="option14">
                                           </td>
                                   </tr>
                                   <tr>
                                       <td class="col-1" ><label class="switch"><input type="checkbox" checked="true" name="algo"  value="15"><span class="slider round"></span></label></td>
                                       <td><text class="btn-link" onclick="myFunction(15)">Averaged 2 Dependence Estimators</text><br/>
                                           <input type="text" style="display:none;" class="form-control" name="option15" id="option15">
                                           </td>
                                   </tr>
                                   <tr>
                                       <td class="col-1" ><label class="switch"><input type="checkbox" checked="true" name="algo"  value="16"><span class="slider round"></span></label></td>
                                       <td><text class="btn-link" onclick="myFunction(16)">Hidden Naive Bayes</text><br/>
                                           <input type="text" style="display:none;" class="form-control" name="option16" id="option16">
                                           </td>
                                   </tr>
                                    <tr>
                                       <td class="col-1" ><label class="switch"><input type="checkbox" checked="true" name="algo"  value="17"><span class="slider round"></span></label></td>
                                       <td><text class="btn-link" onclick="myFunction(17)">Naive Bayes</text><br/>
                                           <input type="text" style="display:none;" class="form-control" name="option17" id="option17">
                                           </td>
                                   </tr>
                                   </table>
                               </div> 
                               <div class="col-md-6">
                                   <h3>Rule</h3>
                                   <table class="table table-borderless table-sm">
                                   <tr>
                                       <td class="col-1" ><label class="switch"><input type="checkbox" checked="true" name="algo"  value="18"><span class="slider round"></span></label></td>
                                       <td><text class="btn-link" onclick="myFunction(18)">Lazy Associative Classifier</text><br/>
                                           <input type="text" style="display:none;" class="form-control" name="option18" id="option18">
                                           </td>
                                   </tr>
                                   <tr>
                                       <td class="col-1" ><label class="switch"><input type="checkbox" checked="true" name="algo"  value="19"><span class="slider round"></span></label></td>
                                       <td><text class="btn-link" onclick="myFunction(19)">Decision Table Naive Bayes</text><br/>
                                           <input type="text" style="display:none;" class="form-control" name="option19" id="option19">
                                           </td>
                                   </tr>
                                   <tr>
                                       <td class="col-1" ><label class="switch"><input type="checkbox" checked="true" name="algo"  value="20"><span class="slider round"></span></label></td>
                                       <td><text class="btn-link" onclick="myFunction(20)">PART</text><br/>
                                           <input type="text" style="display:none;" class="form-control" name="option20" id="option20">
                                           </td>
                                   </tr>
                                   <tr>
                                       <td class="col-1" ><label class="switch"><input type="checkbox" checked="true" name="algo"  value="21"><span class="slider round"></span></label></td>
                                       <td><text class="btn-link" onclick="myFunction(21)">ZeroR</text><br/>
                                           <input type="text" style="display:none;" class="form-control" name="option21" id="option21">
                                           </td>
                                   </tr>
                                    <tr>
                                       <td class="col-1" ><label class="switch"><input type="checkbox" checked="true" name="algo"  value="22"><span class="slider round"></span></label></td>
                                       <td><text class="btn-link" onclick="myFunction(22)">JRip</text><br/>
                                           <input type="text" style="display:none;" class="form-control" name="option22" id="option22">
                                           </td>
                                   </tr>
                                   <tr>
                                       <td class="col-1" ><label class="switch"><input type="checkbox" checked="true" name="algo"  value="23"><span class="slider round"></span></label></td>
                                       <td><text class="btn-link" onclick="myFunction(23)">Decision Table</text><br/>
                                           <input type="text" style="display:none;" class="form-control" name="option23" id="option23">
                                           </td>
                                   </tr>
                                   </table>
                           </div>
                                
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <h3>Function</h3>
                                <table class="table table-borderless table-sm">
                                   <tr>
                                       <td class="col-1" ><label class="switch"><input type="checkbox" checked="true" name="algo"  value="24"><span class="slider round"></span></label></td>
                                       <td><text class="btn-link" onclick="myFunction(24)">Multi Layer Perceptron</text><br/>
                                           <input type="text" style="display:none;" class="form-control" name="option24" id="option24">
                                           </td>
                                   </tr>
                                   <tr>
                                       <td class="col-1" ><label class="switch"><input type="checkbox" checked="true" name="algo"  value="25"><span class="slider round"></span></label></td>
                                       <td><text class="btn-link" onclick="myFunction(25)">Simple Logistic</text><br/>
                                           <input type="text" style="display:none;" class="form-control" name="option25" id="option25">
                                           </td>
                                   </tr>
                                   <tr>
                                       <td class="col-1" ><label class="switch"><input type="checkbox" checked="true" name="algo"  value="26"><span class="slider round"></span></label></td>
                                       <td><text class="btn-link" onclick="myFunction(26)">SMO</text><br/>
                                           <input type="text" style="display:none;" class="form-control" name="option26" id="option26">
                                           </td>
                                   </tr>
                                   <tr>
                                       <td class="col-1" ><label class="switch"><input type="checkbox" checked="true" name="algo"  value="27"><span class="slider round"></span></label></td>
                                       <td><text class="btn-link" onclick="myFunction(27)">Logistic</text><br/>
                                           <input type="text" style="display:none;" class="form-control" name="option27" id="option27">
                                           </td>
                                   </tr>
                                   <tr>
                                       <td class="col-1" ><label class="switch"><input type="checkbox" checked="true" name="algo"  value="28"><span class="slider round"></span></label></td>
                                       <td><text class="btn-link" onclick="myFunction(28)">Kernel Logistic Regression</text><br/>
                                           <input type="text" style="display:none;" class="form-control" name="option28" id="option23">
                                           </td>
                                   </tr>
                                   <tr>
                                       <td class="col-1" ><label class="switch"><input type="checkbox" checked="true" name="algo"  value="28"><span class="slider round"></span></label></td>
                                       <td><text class="btn-link" onclick="myFunction(29)">Linear Regression</text><br/>
                                           <input type="text" style="display:none;" class="form-control" name="option29" id="option29">
                                           </td>
                                   </tr>
                                   </table>
                            </div> 
                            <div class="col-md-6">
                                <table class="table table-borderless table-sm">
                                   
                                   </table>
                            </div>     
                        </div>
                         
                            <input type="submit" class="btn btn-info" value="Run">  <a href="index.jsp" class="btn btn-warning">Back to the previous step</a>
                       </form>  
                        
                        <%
                    }else
                        out.println("<h3>Error: " + content[2] + "</h3>");
                }
                %>
        </div>
   </body>
   
</html>