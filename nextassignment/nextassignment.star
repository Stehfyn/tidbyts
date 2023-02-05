"""
Applet: next_assignment
"""

load("cache.star", "cache")
load("encoding/json.star", "json")
load("http.star", "http")
load("humanize.star", "humanize")
load("render.star", "render")
load("schema.star", "schema")
load("secret.star", "secret")
load("time.star", "time")

CS326 = 91221
CS381 = 91234
CS426 = 91238
CS456 = 93877
CS457 = 93831
CS484 = 96943

SPRING23 = [CS326, CS381, CS426, CS456, CS457, CS484]
SPRING23DICT = {CS326:{"id": "PL", "color": "#F6C"}, CS381:{"id": "GE", "color": "#00F"},CS426:{"id": "SP", "color": "#A30"},CS456:{"id": "TC", "color": "#F00"},CS457:{"id": "DB", "color": "#0F0"},CS484:{"id": "VR", "color": "#90A"}}

CANVAS_TOKEN = "4424~BTa71ppeTR1YVa2mIdOB8c2uFkVGrGnxMq88AR3GhJOtG7JIfEpTr1SDEMSlH932"
CANVAS_URL = "https://webcampus.unr.edu"
AUTH_HEADER = {"Authorization": "Bearer " + CANVAS_TOKEN}

def main():
    classes = get_classes_as_dict(SPRING23)
    assignments = get_assignments_as_list(classes.keys())
    assignments = [a for a in assignments if (a['due_at'] > str(time.now().in_location("Europe/London"))) and a['name'] != '']
    assignments = sorted(assignments, key=lambda a: a['due_at'])

    for a in assignments:
        print(a['class_name'], a.get('name'), a['due_at'][0:10])

    return render.Root(child=do_upcoming_list(assignments), delay=32)

def do_header_marquee(assignments):
    return render.Root(
        child = render.Marquee(
            width=64,
            child=render.Text(assignments[0]['name'], color="#099"),
            offset_start=5,
            offset_end=5,
            align='center',
        )
    )

    child = render.Marquee(width=64, child=render.Text(assignments[0]['name'], font="CG-pixel-4x5-mono", color="#FFF"),offset_start=5,offset_end=5,align='center')

def do_upcoming_list(assignments):
    return render.Row(children=[
        render.Column(
            children=[
                render.Box(width=10, height=6, color="#000", child = render.Text(SPRING23DICT[assignments[0]['class_id']]['id'], font="CG-pixel-4x5-mono", color=SPRING23DICT[assignments[0]['class_id']]['color'])),
                render.Box(width=10, height=6, color="#000", child = render.Text(SPRING23DICT[assignments[1]['class_id']]['id'], font="CG-pixel-4x5-mono", color=SPRING23DICT[assignments[1]['class_id']]['color'])),
                render.Box(width=10, height=6, color="#000", child = render.Text(SPRING23DICT[assignments[2]['class_id']]['id'], font="CG-pixel-4x5-mono", color=SPRING23DICT[assignments[2]['class_id']]['color'])),
                render.Box(width=10, height=6, color="#000", child = render.Text(SPRING23DICT[assignments[3]['class_id']]['id'], font="CG-pixel-4x5-mono", color=SPRING23DICT[assignments[3]['class_id']]['color'])),
                render.Box(width=10, height=6, color="#000", child = render.Text(SPRING23DICT[assignments[4]['class_id']]['id'], font="CG-pixel-4x5-mono", color=SPRING23DICT[assignments[4]['class_id']]['color'])),
            ],
        ),
        render.Column(
            children=[
                render.Box(width=1, height=6, color="#000"),
                render.Box(width=1, height=6, color="#000"),
                render.Box(width=1, height=6, color="#000"),
                render.Box(width=1, height=6, color="#000"),
                render.Box(width=1, height=6, color="#000"),
            ],
        ),
        render.Column(
            children=[
                render.Box(width=43, height=6, color="#000", child = render.Marquee(width=43, child=render.Text(assignments[0].get('name'), font="CG-pixel-4x5-mono", color="#FFF"),offset_start=0,offset_end=0,align='center'),),
                render.Box(width=43, height=6, color="#000", child = render.Marquee(width=43, child=render.Text(assignments[1].get('name'), font="CG-pixel-4x5-mono", color="#FFF"),offset_start=0,offset_end=0,align='center'),),
                render.Box(width=43, height=6, color="#000", child = render.Marquee(width=43, child=render.Text(assignments[2].get('name'), font="CG-pixel-4x5-mono", color="#FFF"),offset_start=0,offset_end=0,align='center'),),
                render.Box(width=43, height=6, color="#000", child = render.Marquee(width=43, child=render.Text(assignments[3].get('name'), font="CG-pixel-4x5-mono", color="#FFF"),offset_start=0,offset_end=0,align='center'),),
                render.Box(width=43, height=6, color="#000", child = render.Marquee(width=43, child=render.Text(assignments[4].get('name'), font="CG-pixel-4x5-mono", color="#FFF"),offset_start=0,offset_end=0,align='center'),),
            ],
        ),
        render.Column(
            children=[
                render.Box(width=1, height=6, color="#000"),
                render.Box(width=1, height=6, color="#000"),
                render.Box(width=1, height=6, color="#000"),
                render.Box(width=1, height=6, color="#000"),
                render.Box(width=1, height=6, color="#000"),
            ],
        ),
        render.Column(
            children=[
                render.Box(width=10, height=6, color="#000", child = render.Text(assignments[0]['due_at'][8:10], font="CG-pixel-4x5-mono", color=SPRING23DICT[assignments[0]['class_id']]['color'])),
                render.Box(width=10, height=6, color="#000", child = render.Text(assignments[1]['due_at'][8:10], font="CG-pixel-4x5-mono", color=SPRING23DICT[assignments[1]['class_id']]['color'])),
                render.Box(width=10, height=6, color="#000", child = render.Text(assignments[2]['due_at'][8:10], font="CG-pixel-4x5-mono", color=SPRING23DICT[assignments[2]['class_id']]['color'])),
                render.Box(width=10, height=6, color="#000", child = render.Text(assignments[3]['due_at'][8:10], font="CG-pixel-4x5-mono", color=SPRING23DICT[assignments[3]['class_id']]['color'])),
                render.Box(width=10, height=6, color="#000", child = render.Text(assignments[4]['due_at'][8:10], font="CG-pixel-4x5-mono", color=SPRING23DICT[assignments[4]['class_id']]['color'])),
            ],
        )], main_align='start',cross_align='start',expanded=True
    )
def get_classes_as_dict(semester):
    params = {
        "per_page": str(100),
        "page": str(1),
        "state[]": "available"
    }
    
    request_url = CANVAS_URL + "/api/v1/courses"
    res = http.get(url=request_url,params=params,headers=AUTH_HEADER)
    classes_as_json = parse_classes(res.json(), semester)
    return to_class_dict(classes_as_json)

def to_class_dict(classes_as_json):
    class_dict = {}
    for c in classes_as_json:
        class_dict.update({int(c["id"]):c})
    return class_dict

def get_assignments_from_id(class_id):
    request_url = CANVAS_URL + "/api/v1/courses/" + str(class_id) + "/assignments"
    res = http.get(url=request_url,headers=AUTH_HEADER)
    return res.json()

def get_quizzes_from_id(class_id):
    request_url = CANVAS_URL + "/api/v1/courses/" + str(class_id) + "/quizzes"
    res = http.get(url=request_url,headers=AUTH_HEADER)
    return res.json()

def parse_classes(resp_as_json, semester):
    classes = []
    for c in resp_as_json:
        if int(c['id']) in semester:
            classes.append(c)
        if len(classes) == len(semester):
            break
    return classes

def get_assignments_as_list(semester):
    return encode_class_id_in_assignments(semester)

def encode_class_id_in_assignments(semester):
    classes = get_classes_as_dict(SPRING23)
    assignments = []
    for class_id in semester:
        class_assignments = get_assignments_from_id(class_id)
        class_assignments += [q for q in get_quizzes_from_id(class_id) if type(q)==type({})]
        for assignment in class_assignments:
            assignment.update({"class_id": int(class_id)})
            assignment.update({"class_name": classes[int(class_id)]['name']})
            if assignment['due_at'] == None:
                assignment.update({"due_at": str(time.now().in_location("Europe/London"))})
            if assignment.get('name') == None:
                assignment.update({'name': ""})
            assignments += [assignment]
    return assignments