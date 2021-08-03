CATALOG=${1:-iso}
MEDIA=${2:-rhcos.iso}

vcd catalog delete -y "$CATALOG" "$MEDIA"
vcd catalog delete -y "$CATALOG"
