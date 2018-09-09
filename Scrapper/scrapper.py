from lxml.etree import tostring
from time import sleep
import lxml
import lxml.html
import requests


def scrap_all_things(category_name, from_page=1):
    page = from_page
    retry = 0
    while True:
        print('scrapping {0}/page:{1}'.format(category_name, str(page)))

        things = scrap_things(category_name, page)
        print('scrapped {2} things for {0}/page:{1}'.format(category_name, str(page), str(len(things))))

        if len(things) == 0:
            print('waiting 5s before retry...')
            sleep(5)

            if retry == 3:
                break
            retry += 1
            continue

        for thing_ in things:
            yield thing_
        page += 1
        retry = 0


def scrap_thing_files(thing_id):
    print(' scrapping files for thing {0}'.format(thing_id))
    files = list(scrap_files(thing_id))
    print(' > scrapped {0} files for thing {1}'.format(str(len(files)), thing_id))
    return files


def scrap_things(category, page=1):
    page = requests.get('https://www.thingiverse.com/explore/{0}/page:{1}'.format(str(category), str(page)))

    tree = lxml.html.fromstring(page.content)
    things = tree.xpath('//*[@data-type="things"]')

    return set(node.xpath('@data-id')[0] for node in things)


class File:
    def __init__(self, thing_id, file_id, filename, content):
        self.thing_id = thing_id
        self.file_id = file_id
        self.filename = filename
        self.content = content


def scrap_files(thing_id):
    page = requests.get('http://www.thingiverse.com/thing:{0}/files'.format(str(thing_id)))
    tree = lxml.html.fromstring(page.content)
    nodes = tree.xpath('//a[@data-file-id]')

    for node in nodes:
        file_id = node.xpath('@data-file-id')[0]
        link = node.xpath('@href')[0]
        filename = node.xpath('@title')[0]
        uri = 'http://www.thingiverse.com{0}'.format(link)
        if filename.lower().endswith(".scad"):
            content = requests.get(uri).content
            yield File(thing_id, file_id, filename, content)
