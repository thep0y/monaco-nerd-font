import os
import sys

from fontTools.ttLib import TTFont

output_dir = sys.argv[1]
version = sys.argv[2]
tag = sys.argv[3]


def set_name(table, nameID, value):
    table.setName(value, nameID, 3, 1, 0x409)


for file in os.listdir(output_dir):
    if not file.endswith((".ttf", ".otf")):
        continue

    path = os.path.join(output_dir, file)
    font = TTFont(path)

    name = font["name"]

    version_str = f"Version {version}; Monaco Nerd Font {tag}"
    unique_id = f"{file}; {version_str}"

    set_name(name, 5, version_str)
    set_name(name, 3, unique_id)

    font["head"].fontRevision = float(version)

    font.save(path)
    print("Updated:", file)
