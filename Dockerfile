FROM tensorflow/tensorflow:2.7.1-gpu

RUN sed -i 's/security.ubuntu.com/mirrors.cloud.tencent.com/g'  /etc/apt/sources.list
RUN sed -i 's/archive.ubuntu.com/mirrors.cloud.tencent.com/g'  /etc/apt/sources.list
RUN apt-get update
RUN apt install -y libsm6 libxext6 libxrender-dev git unzip vim llvm-dev  libgl1-mesa-glx libglib2.0-dev

WORKDIR /opt
ADD https://cdn.npm.taobao.org/dist/node/v16.10.0/node-v16.10.0-linux-x64.tar.xz .
RUN tar -xvf ./node-v16.10.0-linux-x64.tar.xz
ENV PATH="/opt/node-v16.10.0-linux-x64/bin:${PATH}"

RUN mkdir -p ~/.pip

ADD ./files/pip.conf ~/.pip/pip.conf


ADD ./files/requirements.txt .
RUN pip3 install -i https://mirrors.cloud.tencent.com/pypi/simple -r ./requirements.txt
RUN rm -Rf ./requirements.txt
 
WORKDIR /root/.jupyter
ADD ./files/jupyter_notebook_config.py .

WORKDIR /etherfurnace

CMD jupyter lab
