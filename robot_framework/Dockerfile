FROM python:3.8-slim-buster

WORKDIR /app

COPY requirements.txt .

RUN python3 -m venv /venv
ENV PATH="/venv/bin:$PATH"

RUN pip install --upgrade pip && \
    pip install -r requirements.txt

RUN apt-get update && \
    apt-get install -y apt-utils wget gnupg curl unzip

ARG BROWSER

RUN if [ "$BROWSER" = "Chrome" ]; then \
      echo "Installing Chrome..." && \
      wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add - && \
      echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list && \
      apt-get update && \
      apt-get install -y google-chrome-stable; \
    elif [ "$BROWSER" = "Firefox" ]; then \
      echo "Installing Firefox..." && \
      echo "deb http://deb.debian.org/debian/ stable main" >> /etc/apt/sources.list.d/debian.list && \
      apt-get update && \
      apt-get install -y firefox-esr; \
    elif [ "$BROWSER" = "Edge" ]; then \
      echo "Installing Microsoft Edge..." && \
      curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg && \
      install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/ && \
      echo "deb [arch=amd64] https://packages.microsoft.com/repos/edge/ stable main" > /etc/apt/sources.list.d/microsoft-edge-dev.list && \
      apt-get update && \
      apt-get install -y microsoft-edge-dev; \
    elif [ "$BROWSER" = "Opera" ]; then \
      echo "Installing Opera..." && \
      wget -qO- https://deb.opera.com/archive.key | gpg --dearmor > opera.gpg && \
      install -o root -g root -m 644 opera.gpg /etc/apt/trusted.gpg.d/ && \
      echo "deb [arch=amd64] https://deb.opera.com/opera-stable/ stable non-free" > /etc/apt/sources.list.d/opera.list && \
      apt-get update && \
      apt-get install -y opera-stable; \
    fi

COPY . .

ENTRYPOINT python3 -m robot -d results -v BROWSER:$BROWSER -V ./resources/common_variables.py tests
CMD []
