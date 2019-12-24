FROM rocker/tidyverse:3.6.1
RUN R -e 'install.packages("remotes")'
RUN R -e 'remotes::install_github("r-lib/remotes", ref = "97bbf81")'
RUN R -e 'remotes::install_cran("shiny")'
RUN R -e 'remotes::install_cran("golem")'
RUN R -e 'remotes::install_cran("shinydashboard")'
RUN R -e 'remotes::install_cran("processx")'
RUN R -e 'remotes::install_cran("htmltools")'
RUN R -e 'remotes::install_cran("dplyr")'
RUN R -e 'remotes::install_cran("magrittr")'
RUN R -e 'remotes::install_cran("devtools")'
RUN R -e 'devtools::install_github("nstrayer/shinysense")'
RUN R -e 'remotes::install_cran("glmnet")'
RUN R -e 'remotes::install_cran("text2vec")'
RUN R -e 'remotes::install_cran("pkgload")'
COPY riga_*.tar.gz /app.tar.gz
RUN R -e 'remotes::install_local("/app.tar.gz")'
EXPOSE 80
CMD R -e "options('shiny.port'=80,shiny.host='0.0.0.0');riga::run_app()"
