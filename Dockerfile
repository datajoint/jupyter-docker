# Jupyter notebook image based on datajoint/datajoint
# made to be compatible with JupyterHub docker spawner
FROM datajoint/datajoint

MAINTAINER Edgar Y. Walker <edgar.walker@gmail.com>

ADD requirements.txt /requirements.txt
RUN pip install -r /requirements.txt \
    && rm /requirements.txt \
    && mkdir /notebooks

ADD jupyter_notebook_config.py /root/.jupyter/jupyter_notebook_config.py

# fetch jupyterhub-singleuser entrypoint
RUN wget -q https://raw.githubusercontent.com/jupyterhub/jupyterhub/0.6.1/scripts/jupyterhub-singleuser \
         -O /usr/local/bin/jupyterhub-singleuser \
    && chmod 755 /usr/local/bin/jupyterhub-singleuser

ADD start-singleuser.sh /srv/singleuser/start-singleuser.sh

# smoke test the script
RUN sh /srv/singleuser/singleuser.sh -h

EXPOSE 8888
WORKDIR /notebooks
CMD ["/bin/sh", "-c","jupyter notebook"]
