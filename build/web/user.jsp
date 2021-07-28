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
            
        <title>Student</title>
    </head>
    <body>

        <nav>
          <div class="nav-wrapper blue darken-1">
            <a href="#" class="brand-logo center">Course Management System</a>
            
          </div>
        </nav>
        
        <br><br>
        
        
        <div class="row" id="parent_container">
            <div class="col s7 m7 offset-m1" id="all_course_div">
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
            
            <div class="col s7 m7 offset-m1" id="enrolled_course_div">
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

                        <tbody id="enrolled_course_details_table">
                        </tbody>
                    </table>
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
                                     <a href="#" class="btn blue" style="width:70%" id="all"><i class="material-icons left">assignment</i>All Courses</a>
                                 </div>
                            </center>
                        </div>
                       
                        <div class="row">
                            <center>
                                 <div class=" col s12 m12" >
                                     <a href="#" class="btn green" style="width:70%" id="enrolled"><i class="material-icons left">create</i>Enrolled Courses</a>
                                 </div>
                            </center>
                        </div>
                                                  
                        <div class="row">
                            <center>
                                 <div class=" col s12 m12" >
                                     <a href="#" style="width:70%" class="btn red" id="logout"><i class="material-icons left">power_settings_new</i>Log Out</a>
                                 </div>
                            </center>
                        </div>

                    </div>
                </div>
            </div>
        </div>
        
        
        <script>
            $(document).ready(function(){
               $('#enrolled_course_div').hide();
               
               //Ajax for displaying courses
               $.ajax({
                   type :   'post',
                   url  :   'api/getAvilableCourse.jsp',
                   data :   {
                       'currentSession' : localStorage.getItem("currentSession")
                   },
                   success:function(response){
                        
                        response = response.trim();
                        response = JSON.parse(response);
                        
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
                                    let s2 = '<td><a  class="btn-flat green " id="'+response.id[i]+'" onclick="enrollCourse(this.id)"><i class="material-icons" style="color:white;">add</i></a></td></tr>'
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
               $('#all').click(function(){
                   location.reload();
               });
               
               //Show enrolled course div
               $('#enrolled').click(function(){
                    $('#all_course_div').hide();
                    $('#enrolled_course_div').fadeIn(200);
                    $('#enrolled_course_details_table').empty();
                   
                    $.ajax({
                        type    :   'post',
                        url     :   'api/getEnrolledCourse.jsp',
                        data    :   {
                            'currentSession' : localStorage.getItem("currentSession")
                        },
                        success:function(response){
                             
                            response = response.trim();
                            response = JSON.parse(response);
                            
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
                                        let s1 = '<tr id="enrolled_row_'+response.id[i]+'"><td>'+response.name[i]+'</td><td>'+response.description[i]+'</td><td>'+response.fee[i]+'</td>'
                                        let s2 = '<td><a  class="btn-flat red " id="'+response.id[i]+'" onclick="disenrollCourse(this.id)"><i class="material-icons" style="color:white;">delete</i></a></td></tr>'
                                        let s3 = s1+s2;
                                        $('#enrolled_course_details_table').append(s3);
                                    }   
                                }

                            }
                            else
                            {
                                M.toast({html: "Something went wrong. Try again"});
                            }
                        }
                    });

                });
               
               //Log out
               $('#logout').click(function(){
                   window.location.href = "/WebApplication1/";
               })
               
            });
            
            //Function for enrolling course
            function enrollCourse(data_id)
            {
                let row_id = '#row_'+data_id;
                $.ajax({
                    type    :   'post',
                    url     :   'api/enrollCourse.jsp',
                    data    :   {
                        
                        'course_id'         :   data_id,
                        'currentSession'    :   localStorage.getItem("currentSession")
                    
                    },
                    success:function(response){
                        
                        response = response.trim();
                        response = JSON.parse(response);
                        
                        if(response[0].result == "success")
                        {
                            M.toast({html: "Course enrolled successfully!"});
                            $(row_id).remove();
                        }
                        else
                        {
                            M.toast({html: "Something went wrong. Try again."});
                        }
                    }
                });
            }
            
            //Function for disenrolling course
            function disenrollCourse(data_id)
            {
                let row_id = '#enrolled_row_'+data_id;
                $.ajax({
                    type    :   'post',
                    url     :   'api/disenrollCourse.jsp',
                    data    :   {
                        
                        'course_id'         :   data_id,
                        'currentSession'    :   localStorage.getItem("currentSession")
                    
                    },
                    success:function(response){
                        
                        response = response.trim();
                        response = JSON.parse(response);
                        
                        if(response[0].result == "success")
                        {
                            M.toast({html: "Course disenrolled successfully!"});
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
