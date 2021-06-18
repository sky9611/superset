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

COPY docker-entrypoint /var/lib/superset/docker-entrypoint.sh
RUN chmod -x /var/lib/superset/docker-entrypoint.sh
ENTRYPOINT ["/var/lib/superset/docker-entrypoint.sh"]
CMD ["gunicorn", "superset.app:create_app()"]
# CMD ["/bin/bash", "/var/lib/superset/setup.sh"]

# Switch back to using the `superset` user
USER superset