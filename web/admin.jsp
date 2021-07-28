<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
        <!-- Materializd CSS and Icon -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        
        <!-- Scripts -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
            
        <title>Admin</title>
    </head>
    <body>

        <nav>
          <div class="nav-wrapper blue darken-1">
            <a href="#" class="brand-logo center">Course Management System</a>
            
          </div>
        </nav>
        
        <br><br>
        
        
        <div class="row" id="parent_container">
            <div class="col s7 m7 offset-m1" id="course_details_div">
                <div class="card white" style="border:2px solid #1e88e5;">
                    <table>
                        <thead style="background-color:#1e88e5;padding:0%;color:white;">
                          <tr>
                              <th>Name</th>
                              <th>Description</th>
                              <th>Fee</th>
                              <th>Action</th>
                          </tr>
                        </thead>

                        <tbody id="course_details_table">
                        </tbody>
                    </table>
                </div>
            </div>
            
            <div class="col s7 m7 offset-m1" id="add_course_div" >
                <div class="card white" style="border:2px solid #1e88e5;">
                    <div style="background: #1e88e5;padding:4px;">
                       <span class="card-title" > <i class="material-icons postfix" style="color:white">create</i> <b style="color:white">Add new Course</b> </span>
                    </div>
                    <div class="card-content">
                        <div class="row">
                            <div class="input-field col s12">
                                <i class="material-icons prefix" style="color:#1e88e5">account_circle</i>
                                <input id="course_name" name="course_name" type="text" class="validate">
                                <label for="course_name">Course Name</label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="input-field col s12">
                                <i class="material-icons prefix" style="color:#1e88e5">email</i>
                                <input id="course_description" name="course_description"type="text" class="validate">
                                <label for="course_description">Course Description</label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="input-field col s12">
                                <i class="material-icons prefix" style="color:#1e88e5">lock</i>
                                <input id="course_fee" name="course_fee" type="number" class="validate">
                                <label for="course_fee">Course Fee</label>
                            </div>
                        </div>
                        <div class="row">
                            <center>
                                <div class=" col s12 m12">
                                    <a  class="btn blue" id="submit_course"><i class="material-icons right">send</i>Submit</a>
                                </div>
                            </center>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="col s3 m3">
                <div class="card white" style="border:2px solid #1e88e5;">
                    <div>
                       <div style="background-color:#1e88e5;padding:0%;"> 
                            <span class="card-title" > <i class="material-icons postfix" style="color:white">security</i> <b style="color:white">  Control Panel </b> </span>
                       </div> 
                       <br>
                       <div class="row">
                            <center>
                                 <div class=" col s12 m12">
                                     <a href="#" class="btn blue" id="view"><i class="material-icons left">assignment</i>View Courses</a>
                                 </div>
                            </center>
                        </div>
                       
                        <div class="row">
                            <center>
                                 <div class=" col s12 m12" style="width:100%">
                                     <a href="#" class="btn green" id="add"><i class="material-icons left">create</i>Add Courses</a>
                                 </div>
                            </center>
                        </div>
                                                  
                        <div class="row">
                            <center>
                                 <div class=" col s12 m12" >
                                     <a href="#" style="width:55%" class="btn red" id="logout"><i class="material-icons left">power_settings_new</i>Log Out</a>
                                 </div>
                            </center>
                        </div>

                    </div>
                </div>
            </div>
        </div>
        
        
        <script>
            $(document).ready(function(){
               
                $('#add_course_div').hide();
               
               //Ajax for displaying courses
               $.ajax({
                   type     :   'get',
                   url      :   'api/getCourse.jsp',
                   success  :   function(response){
                        
                        response    = response.trim();
                        response    = JSON.parse(response);
                        
                        if(response.result == "success")
                        {
                            if(response.name.length == 0)
                            {
                               M.toast({html: "No Data Avilable !"});
                            }
                            else
                            {
                                for(let i=0;i<response.name.length;i++)
                                {
                                    let s1 = '<tr id="row_'+response.id[i]+'"><td>'+response.name[i]+'</td><td>'+response.description[i]+'</td><td>'+response.fee[i]+'</td>'
                                    let s2 = '<td><a  class="btn-flat red " id="'+response.id[i]+'" onclick="deleteCourse(this.id)"><i class="material-icons" style="color:white;">delete</i></a></td></tr>'
                                    let s3 = s1+s2;
                                    $('#course_details_table').append(s3);
                                }   
                            }

                        }
                        else
                        {
                            M.toast({html: "Something went wrong. Try again"});
                        }
                   }
               });

               //Show course details div 
               $('#view').click(function(){
                   location.reload();
               });
               
               //Show new course div
               $('#add').click(function(){
                   $('#course_details_div').hide();
                   $('#add_course_div').fadeIn(200);
               });
               
               //Ajax for adding new course
               $('#submit_course').click(function(){
                   $.ajax({
                       type :   'post',
                       url  :   'api/addCourse.jsp',
                       data :   {
                           'course_name'        :   $('#course_name').val(),
                           'course_description' :   $('#course_description').val(),
                           'course_fee'         :   $('#course_fee').val()
                       },
                       success:function(response)
                       {
                            response = response.trim();
                            response = JSON.parse(response);

                            if(response[0].result == "success")
                            {
                                M.toast({html: "New course added successfully!"})
                            }
                            else
                            {
                                M.toast({html: "Something went wrong. Try again."})
                            }
                        }
                   });
               });
               
               //Log out
               $('#logout').click(function(){
                   window.location.href = "/WebApplication1/";
               })
               
            });
            
            //Function for deleting course
            function deleteCourse(data_id)
            {
                let row_id = '#row_'+data_id;
                
                $.ajax({
                    type    :   'post',
                    url     :   'api/deleteCourse.jsp',
                    data    :   {
                        'course_id':parseInt(data_id)
                    },
                    success:function(response){
                        
                        response = response.trim();
                        response = JSON.parse(response);
                        if(response.result == "success")
                        {
                            M.toast({html: "Course deleted successfully!"});
                            $(row_id).remove();
                        }
                        else
                        {
                            M.toast({html: "Something went wrong. Try again."});
                        }
                    }
                });
            }
        </script>
    </body>
</html>
