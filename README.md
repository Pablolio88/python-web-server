## Step by Step guide to use this repository  
  
Python code can be found in **Python** directory  
  
Docker image build actions should be run from root folder of the repository with command:  
**docker build -t python_web_server:0.1 -f Docker/Dockerfile .**  
  
To make solution work as expected container should be run with published 8080/tcp port  
**docker run -d -p 8080:8080 --name PyWebServer python_web_server:0.1**

Application is a Web Server with several endpoints:  
1. 8080:/ - returns current weather in London, UK in HTML format, status code 200 OK  
2. 8080/ping - return PONG in HTML format, status code 200 OK  
3. 8080:/health - return HEALTHY, in JSON format, status code 200 OK  

