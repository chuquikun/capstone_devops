# Base image
FROM continuumio/miniconda3:22.11.1

# Working Direct
 ENV work /project/
WORKDIR ${work}

# Copy source code to working directory
COPY my_app ./my_app/
COPY dashboard.yml ./
COPY Makefile ./

# Install packages and dependencies
RUN conda env create --file ./dashboard.yml

# Run python app within the container
EXPOSE 8080
ENTRYPOINT ["conda", "run", "-n", "dash_avocado", "python", "my_app/app.py"]