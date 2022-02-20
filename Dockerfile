# This is the base image that our image builds on. It is based on
# Debian and uses Python 3.7 by default. CUDA 11 is installed.
FROM danieldeutsch/python:3.7-cuda11.0.3-base

# This sets the working directory which will be the location
# from which all of the subsequent commands will be run
WORKDIR /app

# This command (1) downloads the pre-trained model tar, (2) untars the contents,
# and (3) deletes the tar
RUN wget https://dl.fbaipublicfiles.com/fairseq/models/bart.large.cnn.tar.gz && \
    tar -xvf bart.large.cnn.tar.gz --no-same-owner && \
    rm bart.large.cnn.tar.gz

# This command installs a dependency, fairseq, by (1) cloning the original
# repoistory, (2) checking out a specific commit, and (3) running the install
# command with pip
RUN git clone https://github.com/pytorch/fairseq && \
    cd fairseq && \
    git checkout d792b793a777bf660d2aaeb095c2381af189e626 && \
    pip install . --no-cache-dir

# Installing fairseq will install PyTorch, but the default CUDA toolkit version is 10.2. The
# A100 GPUs require a CUDA 11 or higher, so we explicitly reinstall PyTorch with CUDA 11
RUN pip install torch==1.10.0+cu111 -f https://download.pytorch.org/whl/torch_stable.html

# This command installs additional python dependencies
RUN pip install requests==2.26.0 rouge-score==0.0.4 --no-cache-dir

# These commands copy over the data and source code
COPY data data
COPY src src

# Finally, copy over the bash script that reproduces the results
COPY reproduce.sh reproduce.sh

# This is the default command that will be run by docker if one
# is not specified (e.g., `docker run -it --runtime nvidia <image-name>` will
# run this command in the container).
CMD ["sh", "reproduce.sh"]