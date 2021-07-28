# jspWebProject 
<li>The project allows two type of users: Admin and student</li>
<li>The admin is able to login and add/remove courses in the system</li>
<li>The student is able to register and enroll/deenroll the courses added by admin</li>

# How to run ?
<li>Open the web folder</li>
<li>Run index.jsp on server</li>

# Basic flow of working
<li>The system is divied into two parts i.e. Views and Api</li>
<li>The views represent UI files, they reside in "web/" folder</li>
<li>The api files accept the request, performs the database operation and finally returns the desired results</li>
<li>The api files resides "web/api" folder</li>

# Key model 
<li>The view files contains ajax calls, specifying type of request, data to be send and response from api</li>
<li>The api files justwait for request, once the request is arrived it processes the request and returns the data</li>
