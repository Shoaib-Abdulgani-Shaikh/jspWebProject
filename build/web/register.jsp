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
        <title>Register</title>
    </head>
    <body>

        <nav>
          <div class="nav-wrapper blue darken-1">
            <a href="#" class="brand-logo center">Course Management System</a>
            
          </div>
        </nav>
        
        <br><br>
        
        
        <div class="row">
            <div class="col s6 m6 offset-m2" style="margin-left:25%;">
                <div class="card white" style="border:2px solid #1e88e5;">
                    <div style="background: #1e88e5;padding:2%;">
                       <span class="card-title" > <i class="material-icons postfix" style="color:white">create</i> <b style="color:white">  New User Registration </b> </span>
                       
                    </div>
                
                    <div class="card-content" >
                        <div class="row" >
                            <div class="row">
                                <div class="input-field col s6">
                                    <i class="material-icons prefix" style="color:#1e88e5">account_circle</i>
                                    <input id="name" name="name" type="text" class="validate">
                                    <label for="name">Name</label>
                                </div>
                                <div class="input-field col s6">
                                    <i class="material-icons prefix" style="color:#1e88e5">local_phone</i>
                                    <input id="phone" name="phone" type="number" class="validate">
                                    <label for="phone">Phone</label>
                                </div>
                            </div>
                            
                            <div class="row">
                                <div class="input-field col s6">
                                    <i class="material-icons prefix" style="color:#1e88e5">email</i>
                                    <input id="email" name="email"type="text" class="validate">
                                    <label for="email">Email</label>
                                </div>
                                <div class="input-field col s6">
                                    <i class="material-icons prefix" style="color:#1e88e5">business</i>
                                    <input id="address" name="address" type="text" class="validate">
                                    <label for="address">Address</label>
                                </div>
                            </div>
                            
                            <div class="row">
                                <div class="input-field col s6">
                                    <i class="material-icons prefix" style="color:#1e88e5">lock</i>
                                    <input id="password" name="password" type="password" class="validate">
                                    <label for="password">Password</label>
                                </div>
                                <div class="input-field col s6">
                                    <i class="material-icons prefix" style="color:#1e88e5">lock</i>
                                    <input id="cpassword" name="cpassword" type="password" class="validate">
                                    <label for="cpassword">Confirm Password</label>
                                </div>
                            </div>
                            <div class="row">
                                <center>
                                    <div class=" col s12 m12">
                                        <a  class="btn blue" id="submitBtn"><i class="material-icons right">send</i>Submit</a>
                                    </div>
                                </center>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <script>
            
            $(document).ready(function(){
                
               $('#submitBtn').click(function(){
                   $.ajax({
                       type :   'post',
                       url  :   'api/registerUser.jsp',
                       data :   {
                           
                           'user_name'      :   $('#name').val(),
                           'user_phone'     :   $('#phone').val(),
                           'user_email'     :   $('#email').val(),
                           'user_address'   :   $('#address').val(),
                           'user_password'  :   $('#password').val()
                        },
                       success:function(response)
                       {
                           response = response.trim();
                           response = JSON.parse(response);
                           
                           if(response[0].result === "success")
                           {
                               M.toast({html: "Registration Successfull ! Log in to continue."})
                               window.location.href = "/WebApplication1/";
                           }
                           else
                           {
                               M.toast({html: "Something went wrong, Please try again later."})
                           }
                       }
                   });
               });
            });
        </script>
    </body>
</html>
