#!/bin/bash

cd "$( dirname "${BASH_SOURCE[0]}" )"

pandoc fm-uat-guide.md -f markdown+auto_identifiers+definition_lists --smart -V papersize:"a4paper" --standalone --highlight-style tango --number-sections --table-of-contents --toc-depth=2 -o fm-uat-guide.pdf

pandoc fm-user-guide.md -f markdown+auto_identifiers+definition_lists --smart -V papersize:"a4paper" --table-of-contents --toc-depth=3 --standalone --highlight-style tango -o fm-user-guide.pdf

pandoc fm-user-guide.md -f markdown+auto_identifiers+definition_lists --smart --table-of-contents --toc-depth=3 --self-contained --standalone --highlight-style tango -o fm-user-guide.html
