#!/usr/bin/env python3
"""Generate public/index.html."""

from collections import defaultdict
from pathlib import Path

html = "<html>\n<head>\n<title>Teachings</title>\n</head>\n<body>\n<h1>Teachings:</h1>"


def defaultdictlist():
    return defaultdict(list)


data = defaultdict(defaultdictlist)
for f in Path().rglob("*.md"):
    if f.stem == "README":
        continue
    year, cursus, _ = f.parts
    data[year][cursus].append(f.stem)


for year, content in sorted(data.items(), reverse=True):
    html += f'\n<h2 id="{year}">{year}</h2>\n'
    for cursus, slides in sorted(content.items()):
        html += f'<h3 id="{year}-{cursus}">{cursus}</h3>\n<ul>\n'
        for slide in sorted(slides):
            html += f'<li><a href="{year}/{cursus}/{slide}.pdf">{slide}.pdf</a></li>'
        html += "\n</ul>\n"
    break


html += '<hr>\n<a href="src">src</a>\n</body>\n</html>'

with Path("public/index.html").open("w") as f:
    f.write(html)
