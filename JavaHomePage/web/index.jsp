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
                    }else if(content[0].equals("5")){

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
                    </div>
                    <% } %>
                    </div>
                    </div>
                        <%
                        String report = ((String)request.getAttribute("report") != "") ? (String)request.getAttribute("report") : "null";
                        String confMatrix = ((String)request.getAttribute("confmatrix") != "") ? (String)request.getAttribute("confmatrix") : "null";
                        String options = ((String)request.getAttribute("getOptions") != "") ? (String)request.getAttribute("getOptions") : "null";
                        String algo = ((String)request.getAttribute("algo") != "") ? (String)request.getAttribute("algo") : "null";
                        
                        String temp[] = confMatrix.split("@@");
                        int nClassifier = temp.length;
                        double [] Accuracy = new double[nClassifier];
                        double [] Kappa = new double[nClassifier];
                        double [] Fmeasure = new double[nClassifier];
                        double [] Sensitivity = new double[nClassifier];
                        double [] Specificity = new double[nClassifier];
                        out.println("<br/>");
                        for(int i=0;i<nClassifier;i++){
                            String confusionMatrix[] = temp[i].split(";");
                            if(!confusionMatrix[0].equals("-")){
                                int TP = Integer.parseInt(confusionMatrix[0]); 
                                int TN = Integer.parseInt(confusionMatrix[1]); 
                                int FN = Integer.parseInt(confusionMatrix[2]); 
                                int FP = Integer.parseInt(confusionMatrix[3]); 

                                Accuracy[i] = (double)(TP+TN)/(double)(TP+TN+FP+FN);
                                Fmeasure[i] = (double)(2*TP)/(double)(2*TP+FP+FN);
                                Sensitivity[i] = (double)TP/(double)(TP+FN);
                                Specificity[i] = (double)(TN)/(double)(TN+FP);
                                double Po= Accuracy[i];
                                double Pe= (double)((TN+FP)*(FN+TN) + (FN+TP)*(FP+TP))/(double)((TP+TN+FP+FN)*(TP+TN+FP+FN));
                                Kappa[i] = (Po-Pe)/(1-Pe);   
                            }
                            else{
                                Accuracy[i]= -1.0;
                                Fmeasure[i]= -1.0;
                                Sensitivity[i]= -1.0;
                                Specificity[i]= -1.0;
                                Kappa[i]= -1.0;
                            }
                        }
                        
                        double [] CanberraDistance = new double[nClassifier];
                        for(int i=0;i<nClassifier;i++){
                        //accuracy;
                            CanberraDistance[i]=(1-Accuracy[i])/(1+Accuracy[i]);
                        //Fmeasure;
                            CanberraDistance[i]= CanberraDistance[i] + (1-Fmeasure[i])/(1+Fmeasure[i]);
                        //Kappa;
                            CanberraDistance[i]= CanberraDistance[i] + (1-Kappa[i])/(1+Kappa[i]);
                        //Sensitivity;
                            CanberraDistance[i]= CanberraDistance[i] + (1-Sensitivity[i])/(1+Sensitivity[i]);
                        //Specificity;
                            CanberraDistance[i]= CanberraDistance[i] + (1-Specificity[i])/(1+Specificity[i]);
                        }
                        int topTen[] = new int[10];
                        
                        
//                        for(int i=0;i<nClassifier;i++)
                        
                        
                        if(!report.equals("")){
                           // out.println("<br/>" + report + "<br/><br/>" + confMatrix + "<br/><br/>" + options + "<br/>");
%>
            <div class="card">
                <h4 class="card-header">Test Result</h4>                
                <div class="card-body">
                <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.2/Chart.min.js"></script>
                    <nav>
                        <div class="nav nav-tabs" id="nav-tab" role="tablist">
                          <a class="nav-item nav-link active" id="nav-canb-tab" data-toggle="tab" href="#nav-canb"          role="tab" aria-controls="nav-canb"         aria-selected="true">Canberra Distance</a>
                          <!--<a class="nav-item nav-link" id="nav-rank-tab"         data-toggle="tab" href="#nav-rank"           role="tab" aria-controls="nav-rank"          aria-selected="false">Ranking</a>-->
                          <a class="nav-item nav-link" id="nav-acc-tab"         data-toggle="tab" href="#nav-acc"           role="tab" aria-controls="nav-acc"          aria-selected="false">Accuracy</a>
                          <a class="nav-item nav-link" id="nav-f1-tab"          data-toggle="tab" href="#nav-f1"            role="tab" aria-controls="nav-f1"           aria-selected="false">F-Measure</a>
                          <a class="nav-item nav-link" id="nav-kappa-tab"       data-toggle="tab" href="#nav-kappa"         role="tab" aria-controls="nav-kappa"        aria-selected="false">Kappa</a>
                          <a class="nav-item nav-link" id="nav-sensitivity-tab" data-toggle="tab" href="#nav-sensitivity"   role="tab" aria-controls="nav-sensitivity"  aria-selected="false">Sensitivity</a>
                          <a class="nav-item nav-link" id="nav-specificity-tab" data-toggle="tab" href="#nav-specificity"   role="tab" aria-controls="nav-specificity"  aria-selected="false">Specificity</a>

                        </div>
                      </nav>
                      <div class="tab-content" id="nav-tabContent">
                        <div class="tab-pane fade show active" id="nav-canb" role="tabpanel" aria-labelledby="nav-canb-tab">
                            <canvas id="canberra"  height="300" width="600"></canvas>
                            <i class="text-danger">*smaller value means better performance</i>
                        </div>
<!--                        <div class="tab-pane fade" id="nav-rank" role="tabpanel" aria-labelledby="nav-rank-tab">
                            <div class="row">
                                <div class="col-md-6">
                                    <h4>Prediction Rank (based on train data)</h4>
                                </div>
                                <div class="col-md-6">
                                    <h4>Actual Rank (based on test data)</h4>
                                </div>
                            </div>
                        </div>-->
                        <div class="tab-pane fade" id="nav-acc" role="tabpanel" aria-labelledby="nav-acc-tab">
                            <canvas id="accuracy"  height="300" width="600"></canvas>
                            <i>*higher value means better performance</i>
                        </div>
                        <div class="tab-pane fade" id="nav-f1" role="tabpanel" aria-labelledby="nav-f1-tab">
                            <canvas id="fmeasure"  height="300" width="600"></canvas>        
                            <i>*higher value means better performance</i>
                        </div>
                        <div class="tab-pane fade" id="nav-kappa" role="tabpanel" aria-labelledby="nav-kappa-tab">
                            <canvas id="kappa"  height="300" width="600"></canvas>         
                            <i>*higher value means better performance</i>
                        </div>
                        <div class="tab-pane fade" id="nav-sensitivity" role="tabpanel" aria-labelledby="nav-sensitivity-tab">
                            <canvas id="sensitivity"  height="300" width="600"></canvas>         
                            <i>*higher value means better performance</i>
                        </div>
                        <div class="tab-pane fade" id="nav-specificity" role="tabpanel" aria-labelledby="nav-specificity-tab">
                            <canvas id="specificity"  height="300" width="600"></canvas>         
                            <i>*higher value means better performance</i>
                        </div>
                      </div>

                </div>
            </div>
                            <script>
                                
                                <%
                                    boolean algos[] = new boolean[nClassifier];
                                    String temp2[]= algo.split(";");
                                    for(int i=0;i< nClassifier;i++)
                                        algos[i] = (temp2[i].equals("t"))? true:false;
                                    
                                    temp2[0]="";
                                    //accuracy
                                    for(int i=0;i<nClassifier;i++){
                                        if(algos[i]==true)
                                            temp2[0] = temp2[0] + Accuracy[i] + ",";
                                    }
                                    temp2[0] = temp2[0].substring(0, temp2[0].length()-1);
                                %>
                                var internalData = [<% out.print(temp2[0]); %>];
                                
                                <%
                                    //Fmeasure
                                    temp2[0]="";
                                    for(int i=0;i<nClassifier;i++){
                                        if(algos[i]==true)
                                            temp2[0] = temp2[0] + Fmeasure[i] + ",";
                                    }
                                    temp2[0] = temp2[0].substring(0, temp2[0].length()-1);
                                %>
                                var internalData1 = [<% out.print(temp2[0]); %>];
                                
                                <%
                                    //Kappa
                                    temp2[0]="";
                                    for(int i=0;i<nClassifier;i++){
                                        if(algos[i]==true)
                                            temp2[0] = temp2[0] + Kappa[i] + ",";
                                    }
                                    temp2[0] = temp2[0].substring(0, temp2[0].length()-1);
                                %>
                                var internalData2 = [<% out.print(temp2[0]); %>];

                                <%
                                    //Sensitivity
                                    temp2[0]="";
                                    for(int i=0;i<nClassifier;i++){
                                        if(algos[i]==true)
                                            temp2[0] = temp2[0] + Sensitivity[i] + ",";
                                    }
                                    temp2[0] = temp2[0].substring(0, temp2[0].length()-1);
                                %>
                                var internalData3 = [<% out.print(temp2[0]); %>];
                                
                                <%
                                    //Specificity
                                    temp2[0]="";
                                    for(int i=0;i<nClassifier;i++){
                                        if(algos[i]==true)
                                            temp2[0] = temp2[0] + Specificity[i] + ",";
                                    }
                                    temp2[0] = temp2[0].substring(0, temp2[0].length()-1);
                                %>
                                var internalData4 = [<% out.print(temp2[0]); %>];
                                
                                <%
                                    //OverAll - Canberra Distance
                                    temp2[0]="";
                                    for(int i=0;i<nClassifier;i++){
                                        if(algos[i]==true)
                                            temp2[0] = temp2[0] + CanberraDistance[i] + ",";
                                    }
                                    temp2[0] = temp2[0].substring(0, temp2[0].length()-1);
                                %>
                                var internalData5 = [<% out.print(temp2[0]); %>];

                                var algoList = [
                                    <%
                                        String[] listClassifier= {"IBk","KStar","LWL", "LBR",  
                                            "J48", "Decision Stump", "Hoeffding Tree", "LMT", "REP Tree", "Simple Cart", "BFTree", "Random Forest",
                                            "BayesNet", "NB Updateable","A1DE", "A2DE", "Hidden Naive Bayes", "Naive Bayes",  
                                            "LAC", "DTNB", "PART", "ZeroR", "JRip","Decision Table",  
                                            "Multi Layer Perceptron", "SimpleLogistic", "SMO", "Logistic", "Kernel Logistic Regression", "RMV", "MV", "WMV", "RMV2","RDEM"};
                                            temp2[0]="";
                                            for(int i=0;i<nClassifier;i++){
                                                if(algos[i]==true)
                                                    temp2[0] = temp2[0] + "\"" + listClassifier[i] + "\",";
                                            }
                                            temp2[0] = temp2[0].substring(0, temp2[0].length()-1);
                                            out.print(temp2[0]);
                                    %>
                                    ];
                                var graphColors = [];
                                var graphOutlines = [];
                                var hoverColor = [];

                                var internalDataLength = internalData.length;
                                i = 0;
                                while (i <= internalDataLength) {
                                    var randomR = Math.floor((Math.random() * 130) + 100);
                                    var randomG = Math.floor((Math.random() * 130) + 100);
                                    var randomB = Math.floor((Math.random() * 130) + 100);

                                    var graphBackground = "rgb(" 
                                            + randomR + ", " 
                                            + randomG + ", " 
                                            + randomB + ")";
                                    graphColors.push(graphBackground);

                                    var graphOutline = "rgb(" 
                                            + (randomR - 80) + ", " 
                                            + (randomG - 80) + ", " 
                                            + (randomB - 80) + ")";
                                    graphOutlines.push(graphOutline);

                                    var hoverColors = "rgb(" 
                                            + (randomR + 25) + ", " 
                                            + (randomG + 25) + ", " 
                                            + (randomB + 25) + ")";
                                    hoverColor.push(hoverColors);

                                  i++;
                                };

                                var data = {
                                    labels: algoList,
                                    datasets: [{   
                                            data: internalData,
                                            backgroundColor: graphColors,
                                            hoverBackgroundColor: hoverColor,
                                            borderColor: graphOutlines
                                    }]
                                };
                                

                                var options = {
                                    legend: false,
                                    cutoutPercentage: 25,
                                    responsive: true,
                                    "scales":{
                                        "yAxes":[{
                                                "ticks":{
                                                   "suggestedMin": 0.5
                                                   // "beginAtZero":false
                                                }
                                            }]
                                    }

                                };


                                var ctx = document.getElementById("accuracy");
                                var myChart = new Chart(ctx, {
                                    type: 'bar',
                                    data: data,
                                    fill:false,
                                    options: options,
                                    animation: {
                                        animateRotate:true
                                    }
                                });

                                var data1 = {
                                    labels: algoList,
                                    datasets: [{   
                                            data: internalData1,
                                            backgroundColor: graphColors,
                                            hoverBackgroundColor: hoverColor,
                                            borderColor: graphOutlines
                                    }]
                                };
                                var ctx1 = document.getElementById("fmeasure");
                                var myChart1 = new Chart(ctx1, {
                                    type: 'bar',
                                    data: data1,
                                    options: options,
                                    animation: {
                                        animateRotate:true
                                    }
                                });

                                var data2 = {
                                    labels: algoList,
                                    datasets: [{   
                                            data: internalData2,
                                            backgroundColor: graphColors,
                                            hoverBackgroundColor: hoverColor,
                                            borderColor: graphOutlines
                                    }]
                                };
                                var ctx2 = document.getElementById("kappa");
                                var myChart2 = new Chart(ctx2, {
                                    type: 'bar',
                                    data: data2,
                                    options: options,
                                    animation: {
                                        animateRotate:true
                                    }
                                });
                                
                                var data3 = {
                                    labels: algoList,
                                    datasets: [{   
                                            data: internalData3,
                                            backgroundColor: graphColors,
                                            hoverBackgroundColor: hoverColor,
                                            borderColor: graphOutlines
                                    }]
                                };
                                var ctx3 = document.getElementById("sensitivity");
                                var myChart3 = new Chart(ctx3, {
                                    type: 'bar',
                                    data: data3,
                                    options: options,
                                    animation: {
                                        animateRotate:true
                                    }
                                });
                                
                                var data4 = {
                                    labels: algoList,
                                    datasets: [{   
                                            data: internalData4,
                                            backgroundColor: graphColors,
                                            hoverBackgroundColor: hoverColor,
                                            borderColor: graphOutlines
                                    }]
                                };
                                var ctx4 = document.getElementById("specificity");
                                var myChart4 = new Chart(ctx4, {
                                    type: 'bar',
                                    data: data4,
                                    options: options,
                                    animation: {
                                        animateRotate:true
                                    }
                                });
                                
                                var data5 = {
                                    labels: algoList,
                                    datasets: [{   
                                            data: internalData5,
                                            backgroundColor: graphColors,
                                            hoverBackgroundColor: hoverColor,
                                            borderColor: graphOutlines
                                    }]
                                };
                                var ctx5 = document.getElementById("canberra");
                                var myChart5 = new Chart(ctx5, {
                                    type: 'bar',
                                    data: data5,
                                    options: options,
                                    animation: {
                                        animateRotate:true
                                    }
                                });
                            </script>
                            
<%
                        }else 
                            out.println("learning process error<br/>");
                    }else
                        out.println("<h3>Error: " + content[2] + "</h3>");
                }
                %>
        </div>
   </body>
   
</html>