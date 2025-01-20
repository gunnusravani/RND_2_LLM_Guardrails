FROM nvidia/cuda:12.1.0-cudnn8-devel-ubuntu20.04
ARG DEBIAN_FRONTEND=noninteractive
WORKDIR /home

#########################
# ENVIRONMENT SETUP
#########################
RUN apt update
RUN apt install software-properties-common -y
RUN add-apt-repository ppa:deadsnakes/ppa
RUN apt update
RUN apt install python3.10 python3.10-venv python3.10-dev curl -y
RUN curl -sS https://bootstrap.pypa.io/get-pip.py | python3.10
RUN rm /usr/bin/python3
RUN ln -s python3.10 /usr/bin/python3
RUN python3 -m pip install --no-cache-dir --upgrade pip
RUN apt install git python3-git python-is-python3 -y


#########################
# BASIC DEPENDENCIES
#########################
RUN pip install torch==2.1.0 torchvision==0.16.0 torchaudio==2.1.0 --index-url https://download.pytorch.org/whl/cu121
RUN pip install -U scipy scikit-learn nltk rouge_score jupyter
RUN pip install transformers[torch] datasets evaluate metrics peft

#############################
#   PROJECT INSTALLATION
#############################
COPY . /home
RUN pip install openai tiktoken python-dotenv icecream langchain_text_splitters
RUN pip install sacrebleu sentencepiece bert-score sentence-transformers
RUN pip install accelerate bitsandbytes>0.37.0
RUN pip install streamlit
RUN pip install matplotlib
RUN pip uninstall -y transformers
RUN pip install -U git+https://github.com/huggingface/transformers.git
RUN pip install openpyxl

#########################
# CONTAINER SETUP
#########################
WORKDIR /home
CMD /bin/bash