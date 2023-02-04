load("render.star", "render")
load('html.star', 'html')
load("http.star", "http")
load("encoding/base64.star", "base64")

LOCALHOST_IP = "192.168.56.1"
PORT = "8081"

def main():
    rep = http.get("http://" + LOCALHOST_IP + ":" + PORT)
    resp = html(rep.body())
    input = resp.find("#A").text()
    buffer=base64.decode(input)
    return render.Root(
        child = render.Image(src=buffer),
        )
