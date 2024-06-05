# vn

Allows virtual navigation of maps via a text user interface.
(WIP and non-working as of the date of this file)

## Prep

```bash
make
mkdir data
cd data
wget 'https://download.geofabrik.de/north-america/us/west-virginia-latest.osm.pbf' -O wv.pbf
../prep/osmconvert wv.pbf > wv.xml
../prep/1_xml_to_json.py wv.xml
../prep/2_json_to_coords
../prep/3_coords_to_sorted_coords
cd ..
```

## Usage

```bash
./vn
```

## Usage

WIP
- running vn --learn-keys will prompt you for the below shortcuts (useful for terminal/keyboard issues or if these don't click)
- you'll start facing 0 or north
- c-q quits
- a gives summary of what's around you
- m-t switches from relative clock face (default) to true north clockface to degrees
- m-1..m-0 saves your current location
- 1..0 tells you where that location is from your current location
- up and down arrows move in five foot increments
- left and right arrows turn you in that direction
- c-r snaps you to a road
- / searches places
- c-g lets you pick from a list of places to jump to
