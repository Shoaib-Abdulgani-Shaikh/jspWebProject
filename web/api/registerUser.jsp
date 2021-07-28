<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>

<%
    //Declarations of json
    JSONArray list          =   new JSONArray();
    JSONObject obj          =   new JSONObject();
    
    //Accept values arrived with request
    String user_name        =   request.getParameter("user_name");
    String user_phone       =   request.getParameter("user_phone");
    String user_email       =   request.getParameter("user_email");
    String user_address     =   request.getParameter("user_address");
    String user_password    =   request.getParameter("user_password");
    
    try
    {
        //Database operation
        Class.forName("com.mysql.jdbc.Driver");
        Connection dbConn = DriverManager.getConnection("jdbc:mysql://localhost:3306/elearning?characterEncoding=utf8&useSSL=false&useUnicode=true","root","root");
        Statement st = dbConn.createStatement();
        st.execute("insert into user(user_name, user_phone, user_email, user_address, user_password) "
                + "values('"+user_name+"','"+user_phone+"','"+user_email+"', '"+user_address+"', '"+user_password+"')");
        dbConn.close();
        
        //Return data
        obj.put("result","success");
        list.add(obj);
        out.println(list.toJSONString());
        
    } 
    catch(Exception e)
    {
        //Return data in case of error
        out.print(e);
        obj.put("result","fail");
        list.add(obj);
        out.println(list.toJSONString());
    }
    finally
    {
        //Clear console
        out.flush();
    }
%>
