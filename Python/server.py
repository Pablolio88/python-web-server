from http.server import BaseHTTPRequestHandler, HTTPServer
import socketserver
import requests
import xml.etree.ElementTree as ET
import json

class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        if self.path == '/ping':
            self.send_response(200)
            self.send_header('Content-type', 'text/html')
            self.end_headers()
            self.wfile.write(b'PONG')
        elif self.path == '/':
            self.send_response(200)
            self.send_header('Content-type', 'text/html')
            self.end_headers()
            yahoo_rss = self.getPageContent()
            self.wfile.write(f"<h1>Here is RSS:</h1><p>{yahoo_rss}</p>".encode('utf-8'))
        elif self.path == '/health':
            self.send_response(200)
            self.send_header('Content-type', 'application/json')
            self.end_headers()
            self.wfile.write(json.dumps({'status': 'HEALTHY'}).encode('utf-8'))
        else:
            self.send_response(404)
            self.end_headers()
        
    def getPageContent(self):
        page_url = "https://news.yahoo.com/rss"
        try:
            responce = requests.get(page_url)
            content = responce.text
            xml_data_dict = ET.fromstring(content)
            result = []
            for child in xml_data_dict.findall('channel'):
                result.append(f"Feed: {child.findtext('title')}") if child.findtext('title') is not None else None
                result.append(f"Link: {child.findtext('link')}") if child.findtext('link') is not None else None
                result.append(f"Last Build Date: {child.findtext('lastBuildDate')}") if child.findtext('lastBuildDate') is not None else None
                result.append(f"Publish Date: {child.findtext('pubDate')}") if child.findtext('pubDate') is not None else None
                result.append(f"Language: {child.findtext('language')}") if child.findtext('language') is not None else None
            result = ' '.join(result)
            return result
        except Exception as ev:
            return f"Error: {ev}"

def main(server_port: int = 8080):
    with socketserver.TCPServer(('', server_port), Handler) as httpd:
        print(f"Server started at port {server_port}")
        httpd.serve_forever()

if __name__ == '__main__':
    main()