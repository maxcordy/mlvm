import os
from os import makedirs

import ujson

import scrapper
from parameters_extractor import extract_parameters
from scad_parser import parse


def filepath(file, ext=''):
    return "../scadFiles/%s/%s%s" % (file.thing_id, file.file_id, ext)


def delete_dir(dir):
    try:
        os.rmdir(dir)
    except Exception:
        pass


def delete(file):
    try:
        os.remove(file)
    except Exception:
        pass


for thing_id in scrapper.scrap_all_things('customizable', from_page=1):

    if os.path.isdir("../scadFiles/%s/" % thing_id):
        print('%s already exists' % thing_id)
        continue

    for file in scrapper.scrap_thing_files(thing_id):
        try:
            makedirs("../scadFiles/%s/" % file.thing_id, exist_ok=True)

            with open(filepath(file, ".scad"), "wb") as f:
                f.write(file.content)

            parsed = parse(file)
            extracted = extract_parameters(file, parsed)
            export = ujson.dumps(extracted)

            with open(filepath(file, ".json"), "w", encoding="utf-8") as f:
                f.write(export)

        except Exception as err:
            print('Failed to load file %s (thing %s) :' % (file.file_id, file.thing_id))
            print(err)
            delete(filepath(file, ".scad"))
            delete(filepath(file, ".json"))
            delete_dir(filepath(file))
