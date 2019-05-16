FROM rocker/verse:latest

ENV DEBIAN_FRONTEND noninteractive
ENV LC_TIME nb_NO.UTF-8

# debian extras
RUN apt-get update && apt-get install -yq \
    apt-utils \
    bzip2 \
    gdal-bin \
    libgdal-dev \
    libjq-dev \
    libprotobuf-dev \
    libudunits2-dev \
    locales \
    locales-all \
    mysql-client \
    netcat-openbsd \
    protobuf-compiler \
    tzdata \
    unixodbc \
    unixodbc-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# testing: shiny-server just do not get anything but locale C
RUN locale-gen nb_NO.UTF-8

# System locales
ENV LANG=nb_NO.UTF-8
ENV LC_ALL=nb_NO.UTF-8
RUN echo "LANG=\"nb_NO.UTF-8\"" > /etc/default/locale

# making proxy def (and other env vars) go all the way into Rstudio
# console, based on
# https://github.com/rocker-org/rocker-versioned/issues/91
ARG TZ=Europe/Oslo
ENV TZ=${TZ}

ARG PROXY=
ENV http_proxy=${PROXY}
ENV https_proxy=${PROXY}

RUN touch /home/rstudio/.Renviron
RUN echo "TZ=${TZ}" > /home/rstudio/.Renviron
RUN echo "http_proxy=${PROXY}" >> /home/rstudio/.Renviron
RUN echo "https_proxy=${PROXY}" >> /home/rstudio/.Renviron

# add rstudio user to root group  and enable shiny server
ENV ROOT=TRUE

# Install whatever needed in R
RUN R -e "install.packages(c('testthat', 'shinytest'))"
RUN R -e "devtools::install_github('Helseatlas/shinymap')"
RUN R -e "shinytest::installDependencies()"

# Copy PhantomJS executable to somewhere within existing PATH
RUN cp /root/bin/phantomjs /usr/local/bin/.
