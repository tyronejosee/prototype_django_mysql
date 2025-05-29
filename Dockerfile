FROM python:3.12-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set working directory
WORKDIR /code

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    default-libmysqlclient-dev \
    && rm -rf /var/lib/apt/lists/*

# Copy and install requirements
COPY requirements/ requirements/
RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements/local.txt

COPY config/entrypoint.sh /config/entrypoint.sh
RUN chmod +x /config/entrypoint.sh
ENTRYPOINT ["/config/entrypoint.sh"]

# Copy and install app
COPY . .

