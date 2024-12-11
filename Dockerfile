# Use Docker's official Python image
FROM python:3.11

# Set working directory inside the container
WORKDIR /code

# Copy the dependency file to the container
COPY requirements.txt .

# Install dependencies
RUN pip3 install --no-cache-dir -r requirements.txt

# Copy all the application code into the container
COPY . .

# Expose the port on which the Flask app will run
EXPOSE 50505

# Start the application with Gunicorn, specifying host and port
ENTRYPOINT ["gunicorn", "-b", "0.0.0.0:50505", "app:app"]
