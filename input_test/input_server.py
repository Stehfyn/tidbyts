from http.server import HTTPServer, BaseHTTPRequestHandler
from inputs import get_gamepad
import threading
import socket

LOCALHOST = socket.gethostbyname(socket.gethostname())
PORT = 8081

class Controller(object):
    def __init__(self):
        self.A = 0
        self._monitor_thread = threading.Thread(target=self._poll_monitor, args=())
        self._monitor_thread.daemon = True
        self._monitor_thread.start()

    def _poll_monitor(self):
        while True:
            events = get_gamepad()
            for event in events:
                if event.code == 'BTN_SOUTH':
                    self.A = event.state

player = Controller()
class InputHTTP(BaseHTTPRequestHandler):
    def __init__(self, request, client_address, server):
        super().__init__(request, client_address, server)

    def do_GET(self):
        self.send_response(200)
        self.send_header("Content-type", "text/html")
        self.end_headers()
        self.wfile.write(bytes('<html><body><h1 id="A">'+ str(player.A) +'</h1></body></html>', 'utf-8'))


def main():
    print(LOCALHOST)
    server = HTTPServer((LOCALHOST, PORT), InputHTTP)
    print("Input Server now running")
    server.serve_forever()
    server.server_close()
    print("Input Server closed")

if __name__=='__main__':
    main()