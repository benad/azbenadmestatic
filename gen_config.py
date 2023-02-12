#!/usr/bin/env python3

from glob import glob
import json
import sys

def generate():
    routes = []
    config = {"trailingSlash": "auto", "routes": routes}
    targets = [*glob('*.html', root_dir='public')]
    targets.sort()
    for target in targets:
        source = target.replace(".html", ".xml")
        routes.append({"route": "/" + source,
            "redirect": "/" + target,
            "statusCode": 301})
    json.dump(config, sys.stdout, sort_keys=True, indent=None)

if __name__ == '__main__':
    generate()
