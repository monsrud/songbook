#!/bin/sh

rm -f /tmp/songbook_data
rm -rf destination/

cd source

# Convert doc,docx and txt files
lowriter --headless --convert-to pdf *.docx
lowriter --headless --convert-to pdf *.doc
lowriter --headless --convert-to pdf *.txt

# Convert chordpro files to PDF
for i in *.pro; do
    filename=$(basename $i .pro)
    chordpro --no-chord-grids --output=${filename}.pdf $i
done

tempdata="/tmp/songbook_data"

pagenumber=1

for i in *.pdf; do

    # see how many pages the doc is
    pages=$(pdfinfo "$i" | awk '/^Pages:/ {print $2}')
    if [ $pages -gt 1 ]; then
        echo "Skipping $i $pages is more than 1 page long."
        mv $i ${i}.skipped
        continue
    fi

    # remove bookmarks from files
    pdftk A="${i}" cat A1-end output "${i}.tmp" 
    mv "${i}.tmp" "$i"

    printf "BookmarkBegin\nBookmarkTitle: %s\nBookmarkLevel: 1\nBookmarkPageNumber: ${pagenumber}\n" "${i%.*}">> "$tempdata"

    pagenumber=$((++pagenumber))

done

# Print the songs to a PDF
pdftk *.pdf cat output 000_SongBook.tmp.pdf

# Add the bookmarks
pdftk 000_SongBook.tmp.pdf update_info "$tempdata" output 000_SongBook.pdf 

rm -f 000_SongBook.tmp.pdf

mv -f *.pdf ../destination/
