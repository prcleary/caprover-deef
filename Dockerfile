FROM openanalytics/r-base

MAINTAINER Paul Cleary "drprcleary@gmail.com"

# system libraries of general use
RUN apt-get update && apt-get install -y \
    sudo \
    pandoc \
    pandoc-citeproc \
#    libcurl4-gnutls-dev \
    libcairo2-dev \
    libxt-dev \
    libssl1.1 \
    libssh2-1-dev \
    git \
    libcurl4-openssl-dev \
    libxml2-dev

## update system libraries
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get clean

# basic shiny functionality
RUN R -e "install.packages(c('shiny', 'rmarkdown'), repos='https://cloud.r-project.org/')"

# install dependencies of the app
RUN R -e "install.packages(c('data.table', 'DT', 'XML', 'xml2'), repos='https://cloud.r-project.org/')"

# copy the app to the image
RUN mkdir /root/deef
COPY deef /root/deef

COPY Rprofile.site /usr/lib/R/etc/

EXPOSE 3838

CMD ["R", "-e", "shiny::runApp('/root/deef')"]

