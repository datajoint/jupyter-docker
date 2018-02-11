# Jupyter notebook image based on datajoint/datajoint
# made to be compatible with JupyterHub docker spawner
FROM datajoint/datajoint

LABEL maintainer="Edgar Y. Walker <edgar.walker@gmail.com>"

# Export port for Jupyter Notebook
EXPOSE 8888

ADD requirements.txt /requirements.txt
RUN pip install -r /requirements.txt \
    && rm /requirements.txt \
    && mkdir /notebooks

# Hack to deal with weird bug that prevents running `jupyter notebook` directly
# from Docker ENTRYPOINT or CMD.
# Use dumb shell script that runs `jupyter notebook` :(
# https://github.com/ipython/ipython/issues/7062
RUN mkdir -p /scripts
ADD ./run_jupyter.sh /scripts/

# Add Jupyter Notebook config
ADD ./jupyter_notebook_config.py /root/.jupyter/

WORKDIR /notebooks

# By default start running jupyter notebook
ENTRYPOINT ["/scripts/run_jupyter.sh"]
