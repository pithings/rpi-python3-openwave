FROM hmarc/rpi-python3

RUN mkdir -p /usr/src/python_openzwave
WORKDIR /usr/src/python_openzwave

RUN pip3 install --no-cache-dir colorlog cython

RUN apt-get update && \
    apt-get install -y --no-install-recommends cython3 libudev-dev sudo && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY build_python_openzwave /usr/src/python_openzwave/build_python_openzwave
RUN /usr/src/python_openzwave/build_python_openzwave
RUN mkdir -p /usr/local/share/python-openzwave && \
    ln -sf /usr/src/python_openzwave/build/python-openzwave/openzwave/config /usr/local/share/python-openzwave/config

RUN pip3 install --upgrade pip setuptools

CMD ["bash"]
