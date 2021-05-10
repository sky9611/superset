FROM amancevice/superset

# Switching to root to install the required packages
USER root

# Install database drivers
RUN pip install psycopg2
# RUN pip install pyhive
RUN echo 'deb http://cz.archive.ubuntu.com/ubuntu lucid main universe ' > /etc/apt/source.list
RUN apt-get update
RUN apt-get install unixODBC
RUN pip install pyodbc
RUN pip install pymssql

# Switch back to using the `superset` user
USER superset