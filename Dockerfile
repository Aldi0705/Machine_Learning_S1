FROM python:3.6-slim-buster

# Update and install required packages
RUN apt update && \
    apt install -y python3-dev gcc && \
    apt clean

# Set working directory
WORKDIR /app

# Update pip to the latest version
RUN pip install --upgrade pip

# Install torch versi spesifik dan paket lainnya
RUN pip install Flask gunicorn numpy \
    https://download.pytorch.org/whl/cpu/torch-1.0.0-cp36-cp36m-linux_x86_64.whl \
    fastai==1.0.52 torchvision==0.2.1

# Copy application files
ADD models models
ADD src src

# Run a command to trigger densenet download
RUN python src/app.py prepare

# Expose the necessary port
EXPOSE 8008

# Start the server
CMD ["python", "src/app.py", "serve"]
