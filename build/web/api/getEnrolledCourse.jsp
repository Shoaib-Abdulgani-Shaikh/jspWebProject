<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>

<%
    //Declarations of json
    JSONObject obj          =   new JSONObject();
    JSONArray id            =   new JSONArray();
    JSONArray name          =   new JSONArray();
    JSONArray description   =   new JSONArray();
    JSONArray fee           =   new JSONArray();
    
    //Current user id
    int currentSession      =   Integer.parseInt(request.getParameter("currentSession"));
    
    try
    {
        //Database operation
        Class.forName("com.mysql.jdbc.Driver");
        Connection dbConn = DriverManager.getConnection("jdbc:mysql://localhost:3306/elearning?characterEncoding=utf8&useSSL=false&useUnicode=true","root","root");
        Statement st = dbConn.createStatement();
        ResultSet rs = st.executeQuery("select * from course where course_id in (select course_id from enrolled_course where user_id ="+currentSession+");");
        
        while(rs.next())
        {
            id.add(rs.getInt("course_id"));
            name.add( rs.getString("course_name"));
            description.add(rs.getString("course_description"));
            fee.add(rs.getInt("course_fee"));
        }
        
        //Return data
        obj.put("result","success");
        obj.put("id",id);
        obj.put("name",name);
        obj.put("description",description);
        obj.put("fee",fee);
        out.println(obj.toJSONString());
        
        dbConn.close();
        
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
