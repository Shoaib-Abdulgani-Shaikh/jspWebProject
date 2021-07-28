<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>

<%
    //Declarations of json
    JSONObject obj  =   new JSONObject();
    
    //Accept values arrived with request
    int course_id   =   Integer.parseInt(request.getParameter("course_id"));
    
    try
    {
        //Database operation
        Class.forName("com.mysql.jdbc.Driver");
        Connection dbConn = DriverManager.getConnection("jdbc:mysql://localhost:3306/elearning?characterEncoding=utf8&useSSL=false&useUnicode=true","root","root");
        Statement st = dbConn.createStatement();
        st.execute("delete from enrolled_course where course_id ="+course_id+"");
        st.execute("delete from course where course_id ="+course_id+"");
        dbConn.close();
        
        //Return data
        obj.put("result","success");
        out.println(obj.toJSONString());
    } 
    catch(Exception e)
    {
        //Return data in case of error
        out.print(e);
        obj.put("result","fail");
        out.println(obj.toJSONString());
    }
    finally
    {
        //Clear console
        out.flush();
    }
%>
