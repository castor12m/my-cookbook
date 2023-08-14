# Use the official Python image as the base image
FROM python:3.10

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Create and set the working directory
WORKDIR /app

# Copy the requirements file into the container
COPY ./src/requirements.txt /app/

RUN python -m venv /home/venv
RUN echo alias "'ldv=source /home/venv/bin/activate'" >> /root/.bashrc
RUN echo alias "'ddv=deactivate'" >> /root/.bashrc
RUN . /home/venv/bin/activate

# Install the required dependencies
RUN pip install -r requirements.txt

# Copy the rest of the application code into the container
COPY . /app/

# Expose the required ports
EXPOSE 5900

SHELL ["/bin/bash", "-c", "source /home/venv/bin/activate"]

# Start the Flask app
#CMD ["python", "app.py"]

ENTRYPOINT ["tail", "-f", "/dev/null"]
#uvicorn main:app --reload