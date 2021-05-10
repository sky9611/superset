FROM amancevice/superset

# Switching to root to install the required packages
USER root

# Install database drivers
RUN pip install psycopg2
RUN pip install pyhive

# Switch back to using the `superset` user
USER superset