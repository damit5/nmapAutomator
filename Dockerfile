FROM ubuntu:latest

LABEL MAINTAINER="damit5@protonmail.com"

RUN apt-get update \
  && apt-get install -yq --no-install-recommends \
     nmap build-essential libwww-perl git zlib1g-dev nikto rubygems ruby ruby-dev libcurl4-openssl-dev python3-pip -y \
  && gem install wpscan \
  && pip3 install droopescan dnsrecon \
  && pip3 install -r /codebase/tools/smbmap/requirements.txt \
  # && apt-get autoremove \
  # && rm -rf /var/lib/apt/lists/*

WORKDIR /codebase

COPY . .

# tools
RUN cp -af tools/vulners.nse /usr/share/nmap/scripts/vulners.nse \
 && cd tools/sslscan && make static && ln sslscan /usr/local/bin/sslscan && cd ../../ \
 && ln tools/ffuf /usr/local/bin/ffuf \
 && ln tools/gobuster /usr/local/bin/gobuster \
 && alias joomscan='perl /codebase/tools/joomscan/joomscan.pl ' \
 && alias smbmap='python3 /codebase/tools/smbmap/smbmap.py ' \
 && alias enum4linux='perl /codebase/tools/enum4linux/enum4linux.pl ' \
 && alias smtp-user-enum='perl /codebase/tools/smtp-user-enum/smtp-user-enum.pl '