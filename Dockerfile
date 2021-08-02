FROM amancevice/superset

# Switching to root to install the required packages
USER root

# Install OpenSSH and set the password for root to "Docker!". In this example, "apk add" is the install instruction for an Alpine Linux-based image.
RUN apt-get update && apt-get install -y openssh-server \
     && echo "root:Docker!" | chpasswd 

# Copy the sshd_config file to the /etc/ssh/ directory
COPY sshd_config /etc/ssh/

# Generate host keys
RUN ssh-keygen -P "" -t dsa -f /etc/ssh/ssh_host_dsa_key

# Open port 2222 for SSH access
EXPOSE 80 2222

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
RUN pip install mysqlclient
RUN pip install pymysql
RUN pip install Authlib
RUN pip install sqlalchemy-clickhouse

# COPY setup.sh /var/lib/superset/setup.sh
# RUN chmod -x /var/lib/superset/setup.sh
# CMD ["/bin/bash", "/var/lib/superset/setup.sh"]

# COPY ./docker-entrypoint.sh /
# RUN chmod 0755 /docker-entrypoint.sh
# ENTRYPOINT ["/docker-entrypoint.sh"]
# CMD ["gunicorn", "superset.app:create_app()"]

COPY init.sh /usr/local/bin/
ENTRYPOINT ["bash", "init.sh"]

# # Switch back to using the `superset` user
# USER superset