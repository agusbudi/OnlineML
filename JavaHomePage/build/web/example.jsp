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
       <link rel="stylesheet" href="css/bootstrap.min.css"/>         
       <script src="js/bootstrap.min.js"></script>         
   </head>
   
   
    <body>
        <div class="container">
            <h2>Topdown Supervised Learning 101</h2>
            
            <!--Search Form -->
            <form action="/employee" method="get" id="seachEmployeeForm" role="form">
                <input type="hidden" id="searchAction" name="searchAction" value="searchByName">
                <div class="form-group col-xs-5">
                    <input type="text" name="employeeName" id="employeeName" class="form-control" required="true" placeholder="Type the Name or Last Name of the employee"/>                    
                </div>
                <button type="submit" class="btn btn-info">
                    <span class="glyphicon glyphicon-search"></span> Search
                </button>
                <br></br>
                <br></br>
            </form>
            
        </div>
      
      <form action="GetPost" method="POST">
       First Name: <input type="text" name="firstName" size="20"><br />
       Surname: <input type="text" name="surname" size="20">
       <br /><br />
       
        <input type="checkbox" name="id" value="Java"> Java<BR>
        <input type="checkbox" name="id" value=".NET"> .NET<BR>
        <input type="checkbox" name="id" value="PHP"> PHP<BR>
        <input type="checkbox" name="id" value="C/C++"> C/C++<BR>
        <input type="checkbox" name="id" value="PERL"> PERL <BR>
       <input type="submit" value="Submit">
      </form>
      
      
      Select a file to upload: <br />
        <form action="fileupload.jsp" method="post" enctype="multipart/form-data">
        <input type="file" name="file" size="50" />
        <br />
        <input type="submit" value="Upload File" />
        </form>

   </body>
   
</html>