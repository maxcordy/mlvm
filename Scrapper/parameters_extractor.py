from os import makedirs, path
from os.path import isfile, abspath
import re


def find(x):
    for xx in x:
        return xx


text_pattern = re.compile(".*([A-Za-z]{2,} +[A-Za-z]{2,}.*){2,}.*")


def param_by_values(values):
    values = values.strip()
    if values[-1:] in [';', '.']:
        values = values[:-1].strip()

    if values == '' or text_pattern.match(values):
        return None
    elif values[0] == '[' and values[-1] == ']':
        if values.find(',') >= 0:
            enum = values[1:-1].split(',')
            if all(':' in p for p in enum):
                return dict(type='enum', values=[v[:v.find(':')] for v in enum])
            else:
                return dict(type='enum', values=enum)
        elif values.find(':') >= 0:
            e = values[1:-1].split(':')
            try:
                a = float(e[0])
                if len(e) == 2:
                    b = float(e[1])
                    return dict(type='range', start=a, end=b, step=(1 if (a <= b) else -1))
                elif len(e) == 3:
                    b = float(e[1])
                    c = float(e[2])
                    return dict(type='range', start=a, end=c, step=b)
            except ValueError as ex:
                pass

            if e[0] in {'image_surface', 'image_array', 'draw_polygon'}:
                return dict(type='custom', function=e[0], parameters=e[1:])

                # raise Exception('Unknown special type: ' + e[1])

        else:
            return dict(type='constant')

    if values == 'in mm':
        return dict(type='float')

    print('Unrecognized values "' + values + '"')
    return None


def isfloat(x):
    try:
        value = float(x)
        return True
    except ValueError as e:
        return False


def get_filename(file):
    uri = file['uri']
    return uri[uri.rfind(':') + 1:]


def find_declaration_lines(file, p):
    c = file.content.split('\n')
    loc = p['location'].split(':')

    return '\n'.join(c[int(loc[0]) - 2:int(loc[0]) + 2])


def extract_parameters(file, parameters):
    nparams = {}

    for p in parameters:
        # 'values', 'name', 'location', 'description', 'section'
        name = p['name']
        if 'section' in p and p['section'].lower() == 'hidden':  # quick fix error in parser
            continue

        try:
            if 'values' in p:
                values = p['values']
                c = param_by_values(values)
                if c is not None:
                    nparams[name] = c

            if name not in nparams and 'defaultType' in p:
                nparams[name] = p['defaultType']

            if name in nparams and nparams[name]['type'] == 'constant':
                nparams.pop(name, None)

        except Exception as e:
            for p1 in parameters:
                print(p1)
            print(path.abspath('../scadFiles/' + file.thing_id + '/' + file.file_id + '.scad'))
            print(find_declaration_lines(file, p))
            print('---------')
            raise

    return nparams
