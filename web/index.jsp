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
            
        <title>Home Page</title>
    </head>
    <body>

        <nav>
          <div class="nav-wrapper blue darken-1">
            <a href="#" class="brand-logo center">Course Management System</a>
            
          </div>
        </nav>
        
        <br><br>
        
        
        <div class="row">
            <div class="col s4 m4 offset-m4">
                <div class="card white" style="border:2px solid #1e88e5;">
                    <div style="background: #1e88e5;padding:4%;">
                       <span class="card-title" > <i class="material-icons postfix" style="color:white">security</i> <b style="color:white">  User Log In </b> </span>
                       
                    </div>
                
                    <div class="card-content" >
                        <div class="row" >
                            <div class="row">
                                <div class="input-field col s12">
                                    <i class="material-icons prefix" style="color:#1e88e5">email</i>
                                    <input id="email" type="text" class="validate">
                                    <label for="email">Email</label>
                                </div>
                            </div>
                            <div class="row">
                                <div class="input-field col s12">
                                    <i class="material-icons prefix" style="color:#1e88e5">lock</i>
                                    <input id="password" type="password" class="validate">
                                    <label for="password">Password</label>
                                </div>
                            </div>
                            <div class="col s6 m6">
                                <label style="color:#1e88e5">
                                    <input class="with-gap"  id="r1" name="usertype" value="user" type="radio" />
                                    <span>Student</span>
                                </label>
                            </div>
                            <div class="col s6 m6" >
                                <label style="color:#1e88e5">
                                    <input class="with-gap " id="r2" name="usertype" value="admin" type="radio" />
                                    <span>Admin</span>
                                </label>
                            </div>
                            
                            <br><br>
                            
                            <div class="row">
                                <center>
                                    <div class=" col s12 m12">
                                        <a href="#" class="btn blue" id="submitBtn"><i class="material-icons right">send</i>Submit</a>
                                    </div>
                                </center>
                            </div>
                           <center>
                            <a href="register.jsp"> <i style="color:gray">Don't have account? click here to register</i></a>
                           </center>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <script>
            $(document).ready(function(){
               $('#submitBtn').click(function(){
                  let user_type = $("input[name='usertype']:checked").val();
                  $.ajax({
                      url   :   'api/logIn.jsp',
                      type  :   'post',
                      data  :{
                          'user_email'      :   $('#email').val(),
                          'user_password'   :   $('#password').val(),
                          'user_type'       :   $("input[name='usertype']:checked").val()
                      },
                      success:function(response)
                      {
                          console.log(response);
                          response  = response.trim();
                          response  = JSON.parse(response);
                          
                          if(response[0].result == "success")
                          {
                              M.toast({html: "Login Successful"})
                              if(user_type == "user")
                              {
                                localStorage.setItem("currentSession", response[0].user_id);
                                window.location.href = "/WebApplication1/user.jsp";  
                              }else if(user_type == "admin")
                              {
                                window.location.href = "/WebApplication1/admin.jsp";
                              }
                              
                          }
                          else if(response[0].result == "invalid credentials")
                          {
                              M.toast({html: "Invalid Credentials"})
                          }
                          else
                          {
                              M.toast({html: "Something went wrong. try again."})
                          }
                          
                      }
                  });
               }); 
            });
        </script>
    </body>
</html>
