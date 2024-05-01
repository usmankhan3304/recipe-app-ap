FROM python:3.9-alpine3.13
ENV PYTHONUNBUFFERED 1

# Copy the requirements file into the container
COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.dev.txt /tmp/requirements.dev.txt

# Copy the project files into the container
COPY ./app /app

# Set the working directory
WORKDIR /app

# Expose port 8000
EXPOSE 8000
ARG DEV=false
# Create a virtual environment, install dependencies, and remove temporary files
RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install -r /tmp/requirements.txt && \
    if [ "$DEV" = "true" ]; then \
        /py/bin/pip install -r /tmp/requirements.dev.txt; \
    fi && \
    rm -rf /tmp && \
    adduser --disabled-password --no-create-home django-user

# Install flake8
RUN pip install flake8
# Set the PATH environment variable
ENV PATH="/py/bin:$PATH"

# Switch to the non-root user
USER django-user
