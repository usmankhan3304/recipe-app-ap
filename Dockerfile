FROM python:3.9-alpine3.13

# Set environment variables
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

# Install system dependencies
RUN apk add --update --no-cache postgresql-client \
    && apk add --update --no-cache \
        build-base \
        postgresql-dev \
        musl-dev \
    && python -m venv /py \
    && /py/bin/pip install --upgrade pip \
    && /py/bin/pip install -r /tmp/requirements.txt \
    && if [ "$DEV" = "true" ]; then /py/bin/pip install -r /tmp/requirements.dev.txt; fi \
    && rm -rf /tmp

# Install flake8
RUN /py/bin/pip install flake8

# Add a non-root user
RUN adduser --disabled-password --no-create-home django-user

# Set the PATH environment variable
ENV PATH="/py/bin:$PATH"

# Switch to the non-root user
USER django-user
