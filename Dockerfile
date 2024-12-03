# Use Ubuntu 24.10 as the base image
FROM ubuntu:22.04

# Set the working directory in the container
WORKDIR /code

# Update the system and install necessary packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 \
    python3-pip \
    python3-venv \
    git \
    wget \
    libgl1-mesa-glx \
    libglib2.0-0 \
    libegl1 \
    ffmpeg \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*


RUN git clone --recursive https://github.com/Cryhouse/WiLoR.git

RUN python3 -m venv venv 

# RUN . venv/bin/activate && python -m ensurepip --upgrade
RUN wget https://huggingface.co/spaces/rolpotamias/WiLoR/resolve/main/pretrained_models/detector.pt -P ./WiLoR/pretrained_models/ && wget https://huggingface.co/spaces/rolpotamias/WiLoR/resolve/main/pretrained_models/wilor_final.ckpt -P ./WiLoR/pretrained_models/

# Install the requirements in the virtual environment
RUN . venv/bin/activate && python -m ensurepip --upgrade && pip install numpy && pip install dill && pip install --no-cache-dir -r WiLoR/requirements.txt

# COPY MANO_RIGHT.pkl ./WiLoR/mano_data/MANO_RIGHT.pkl
# docker build -t wilor-test .
# docker run -it --rm -v /home/ubuntu/mnt:/code/mnt wilor-test
# python demo.py --img_folder demo_img --out_folder ../mnt