<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>

<%
    //Declarations of json
    JSONArray list          =   new JSONArray();
    JSONObject obj          =   new JSONObject();
    
    //Accept values arrived with request
    String user_email       =   request.getParameter("user_email");
    String user_password    =   request.getParameter("user_password");
    String user_type        =   request.getParameter("user_type");
     
    try
    {
        //Database operation
        Class.forName("com.mysql.jdbc.Driver");
        Connection dbConn = DriverManager.getConnection("jdbc:mysql://localhost:3306/elearning?characterEncoding=utf8&useSSL=false&useUnicode=true","root","root");
        Statement stmt = dbConn.createStatement();
        ResultSet rs = stmt.executeQuery("select * from "+user_type+" where "+user_type+"_email='"+user_email+"' and "+user_type+"_password='"+user_password+"' ");
        
        int user_id=0;
        int ctr = 0;
        
        while(rs.next())
        {
            user_id = rs.getInt(user_type+"_id");
            ctr+=1;
        }
        
        //Return data
        if (ctr != 0)
        {
            obj.put("result","success");
            obj.put("user_id",user_id);
            list.add(obj);
            out.println(list.toJSONString());
        }
        else
        {
            obj.put("result","invalid credentials");
            list.add(obj);
            out.println(list.toJSONString());
        }
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
