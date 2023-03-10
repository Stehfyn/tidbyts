load("render.star", "render")
load("encoding/base64.star", "base64")

waterfall=base64.decode("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")

def main():
    return render.Root(
        child = render.Box(
                render.Row(
                expanded=False,
                main_align="space_evenly",
                cross_align="center",
                children = [
                    render.Image(src=waterfall),
                    render.Text(" 32x32"),
                ],
            ),
        ),
    )
