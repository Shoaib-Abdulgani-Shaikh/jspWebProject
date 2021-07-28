<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>

<%
    //Declarations of json
    JSONArray list      =   new JSONArray();
    JSONObject obj      =   new JSONObject();
    
    //Accept values arrived with request
    int currentSession  =   Integer.parseInt(request.getParameter("currentSession"));
    int course_id       =   Integer.parseInt(request.getParameter("course_id"));
    
    try
    {
        //Database operation
        Class.forName("com.mysql.jdbc.Driver");
        Connection dbConn = DriverManager.getConnection("jdbc:mysql://localhost:3306/elearning?characterEncoding=utf8&useSSL=false&useUnicode=true","root","root");
        Statement st = dbConn.createStatement();
        st.execute("delete from enrolled_course where user_id ="+currentSession+" and course_id="+course_id+"");
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
