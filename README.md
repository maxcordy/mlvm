
# Parser 
Java project, use `antlr4` to generate the parser;

## Build
Using maven : execute the goal `package`.

## Usage
Called by Scrapper (in `scad_parser.py`).

# Scrapper
Python project. Requires `lxml` (https://lxml.de/installation.html).

## Usage

First, build the project Parser.
Then run `main.py`.
The resulting directory `../scadFiles` will contains the SCAD files and variability model (as json). 
