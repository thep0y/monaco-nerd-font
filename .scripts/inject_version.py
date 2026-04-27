import os
import sys

from fontTools.ttLib import TTFont

output_dir = sys.argv[1]  # 字体输出目录
version = sys.argv[2]  # 本项目版本，如 "0.2.2"
tag = sys.argv[3]  # 本项目 tag，如 "v0.2.2"
nerd_tag = sys.argv[4]  # 上游 Nerd Fonts 版本，如 "v3.2.1"


def set_name(table, nameID, value):
    table.setName(value, nameID, 3, 1, 0x409)


for file in os.listdir(output_dir):
    if not file.endswith((".ttf", ".otf")):
        continue

    path = os.path.join(output_dir, file)
    font = TTFont(path)
    name = font["name"]

    # 版本字符串同时体现本项目版本与上游 Nerd Fonts 版本
    version_str = f"Version {version}; Nerd Fonts {nerd_tag}"
    unique_id = f"{file}; {version_str}"

    set_name(name, 5, version_str)
    set_name(name, 3, unique_id)

    # 保留原始的 fontRevision，不做修改，避免降级问题
    font.save(path)
    print("Updated:", file)
