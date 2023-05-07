FROM alpine:3.8
RUN apk update \
&& apk add libreoffice-writer pdftk poppler-utils perl-utils perl-dev make gcc musl-dev msttcorefonts-installer fontconfig \ 
&& update-ms-fonts && fc-cache -f && apk update && apk add terminus-font font-noto font-misc-misc \
&& yes | cpan install wx Compress::Raw::Bzip2 IO::Compress::Base chordpro \
&& mkdir -p /root/.config/wxchordpro/ \
&& mkdir -p /etc/chordpro
WORKDIR /songbook
CMD ["./songbook.sh"]



