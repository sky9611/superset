FROM amancevice/superset

# Switching to root to install the required packages
USER root

# Install database drivers
RUN pip install psycopg2
RUN pip install pyhive
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl https://packages.microsoft.com/config/ubuntu/20.10/prod.list > /etc/apt/sources.list.d/mssql-release.list
RUN apt-get update
RUN ACCEPT_EULA=Y apt-get install -y msodbcsql17
RUN . ~/.bashrc
RUN apt-get install -y unixodbc-dev
RUN pip install pyodbc
RUN pip install pymssql
RUN pip install Authlib

# Add SSH

ENV SSH_PASSWD "root:Docker!"
RUN apt-get update \
        && apt-get install -y --no-install-recommends dialog \
        && apt-get update \
  && apt-get install -y --no-install-recommends openssh-server \
  && echo "$SSH_PASSWD" | chpasswd 

COPY sshd_config /etc/ssh/

EXPOSE 8000 2222

RUN service ssh start

# Switch back to using the `superset` user
USER superset