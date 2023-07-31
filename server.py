import os
import http.server
import socketserver
import requests
import json

Handler = http.server.SimpleHTTPRequestHandler

def main(server_port: int = 8080):
    with socketserver.TCPServer(('', server_port), Handler) as httpd:
        print(f"Server started at port {server_port}")
        httpd.serve_forever()

if __name__ == '__main__':
    main()