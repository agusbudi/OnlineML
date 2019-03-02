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
                    out.println("<h4><i>Unable to read the file</i></h4>");
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
                        if(!report.equals("")){
                           // out.println("<br/>" + report + "<br/><br/>" + confMatrix + "<br/><br/>" + options + "<br/>");
%>
                        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.2/Chart.min.js"></script>
                            <nav>
                                <div class="nav nav-tabs" id="nav-tab" role="tablist">
                                  <a class="nav-item nav-link active" id="nav-acc-tab" data-toggle="tab" href="#nav-acc" role="tab" aria-controls="nav-acc" aria-selected="true">Accuracy</a>
                                  <a class="nav-item nav-link" id="nav-f1-tab" data-toggle="tab" href="#nav-f1" role="tab" aria-controls="nav-f1" aria-selected="false">F-Measure</a>
                                  <a class="nav-item nav-link" id="nav-kappa-tab" data-toggle="tab" href="#nav-kappa" role="tab" aria-controls="nav-kappa" aria-selected="false">Kappa</a>
                                  <a class="nav-item nav-link" id="nav-sensitivity-tab" data-toggle="tab" href="#nav-sensitivity" role="tab" aria-controls="nav-sensitivity" aria-selected="false">Sensitivity</a>
                                  <a class="nav-item nav-link" id="nav-specificity-tab" data-toggle="tab" href="#nav-specificity" role="tab" aria-controls="nav-specificity" aria-selected="false">Specificity</a>
                                  
                                </div>
                              </nav>
                              <div class="tab-content" id="nav-tabContent">
                                <div class="tab-pane fade show active" id="nav-acc" role="tabpanel" aria-labelledby="nav-acc-tab">
                                    <canvas id="accuracy"  height="300" width="600"></canvas>
                                </div>
                                <div class="tab-pane fade" id="nav-f1" role="tabpanel" aria-labelledby="nav-f1-tab">
                                    <canvas id="fmeasure"  height="300" width="600"></canvas>        
                                </div>
                                <div class="tab-pane fade" id="nav-kappa" role="tabpanel" aria-labelledby="nav-kappa-tab">
                                    <canvas id="kappa"  height="300" width="600"></canvas>         
                                </div>
                                <div class="tab-pane fade" id="nav-sensitivity" role="tabpanel" aria-labelledby="nav-sensitivity-tab">
                                    <canvas id="sensitivity"  height="300" width="600"></canvas>         
                                </div>
                                <div class="tab-pane fade" id="nav-specificity" role="tabpanel" aria-labelledby="nav-specificity-tab">
                                    <canvas id="specificity"  height="300" width="600"></canvas>         
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

                                var algoList = [
                                    <%
                                        String[] listClassifier= {"IBk","KStar","LWL", "LBR",  
                                            "J48", "Decision Stump", "Hoeffding Tree", "LMT", "REP Tree", "Simple Cart", "BFTree", "Random Forest",
                                            "BayesNet", "NB Updateable","A1DE", "A2DE", "Hidden Naive Bayes", "Naive Bayes",  
                                            "LAC", "DTNB", "PART", "ZeroR", "JRip","Decision Table",  
                                            "Multi Layer Perceptron", "SimpleLogistic", "SMO", "Logistic", "Kernel Logistic Regression"};
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