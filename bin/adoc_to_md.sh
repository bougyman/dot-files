#!/usr/bin/env bash
if ! command -v asciidoctor >/dev/null 2>&1
then
    echo "Unable to find asciidoctor. Please 'gem install asciidoctor asciidoctor-diagram'"
    exit 1
fi
if ! command -v pandoc >/dev/null 2>&1
then
    echo "Unable to find pandoc. Please install pandoc"
    exit 1
fi
infile=$1
justfile="$(basename "$infile")"
outdir="$(dirname "$infile")"
outxml="$outdir/${justfile%.*}.xml"
outmd="$outdir/${justfile%.*}.md"

if ! asciidoctor -r asciidoctor-diagram -b docbook -o "$outxml" "$infile" 
then
    echo "Asciidoctor conversion failed, please correct the errors from the output above and try again" >&2
    exit 1
fi
pandoc --from docbook --to gfm --output "$outmd" < "$outxml"
rm -vf "$outxml"

echo wrote "$outmd"
