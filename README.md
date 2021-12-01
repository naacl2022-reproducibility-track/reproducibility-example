# Dockerization Tutorial
This repository contains the code which corresponds to the Dockerization tutorial.
It contains code for a fake paper which fine-tunes [BART](https://arxiv.org/abs/1910.13461) on the CNN/DailyMail summarization dataset and reports a [ROUGE](https://aclanthology.org/W04-1013/) score.

## Contents
The repository contains the following contents:

    - `data/`
        - `documents.txt`: 10 input documents from the CNN/DailyMail dataset, one per line
        - `references.txt`: The 10 reference summaries corresponding to `documents.txt`, one per line
        
    - `src/`
        - `summarize.py`: The inference code which loads the pre-trained model and generates summaries
        - `evaluate.py`: The script which calculates ROUGE between the predicted and reference summaries
        
    - `Dockerfile`: The final Dockerfile created in the tutorial
    - `reproduce.sh`: The script which is run within the Docker container and outputs the string which is used to verify the results are reproducible.

## Reproducing the Results
The Docker image can be built by running:
```shell script
docker build -t tutorial .
```
The `tutorial` argument is the name of the image.

Then, you can run the container on the CPU with this command:
```shell script
docker run -it tutorial
```
The expected result is
```json
{"rouge1": "40.19", "rouge2": "16.41"}
```

The command using the GPU is
```shell script
docker run -it --gpus 0 tutorial
```
and the expected result is
```json
{"rouge1": "40.95", "rouge2": "18.56"}
```

## Issues & Questions
If you encounter any problems or have any questions, please open up an issue on this repository's GitHub page.
