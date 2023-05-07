# SongBook

This is a Docker project that creates an indexed pdf songbook out of doc, docx, pdf, pro (chordpro) and txt files in the source directory.
The songbook 000_SongBook.pdf and PDF version of all the files will be created in the destination directory.
Only 1 page songs will be added to the songbook. If a song doc contains more than a single page,
it will converted to pdf but will not be added to the songbook. (The one page limit is just what works for
me on my iPad so I don't need to scroll.) Chordpro, libreoffice-writer, pdftk and pdfinfo are used to 
process the files into PDFs. All the PDFs are combined and a bookmark index is applied.

1) Place .doc, .docx, .pdf, .pro (chordpro) and .txt files into the "source" directory. 
2) Run: docker-compose up
3) A songbook (OOO_SongBook.pdf) and a PDF version of the song files will be created in the destination directory.

If running outside of docker, the following packages need to be installed:

    libreoffice-writer pdftk poppler-utils perl-utils perl-dev make gcc musl-dev

Chordrpo also needs to be installed:

    yes | cpan install wx Compress::Raw::Bzip2 IO::Compress::Base chordpro

## Force re-creation of the container:
docker-compose up --build --force-recreate

## Command line of container:
docker run -it -v .:/songbook songbook_songbook /bin/sh
