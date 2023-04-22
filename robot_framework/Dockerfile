# Kiinduló kép
FROM python:3.8-slim-buster

# Munkaknyvtár létrehozása
WORKDIR /app

# Másolja a projekt követelményeit a konténerbe
COPY requirements.txt .

# Telepítse a követelményeket
RUN pip3 install --trusted-host pypi.python.org -r requirements.txt

RUN apt-get update && \
    apt-get install -y wget gnupg curl unzip

ARG BROWSER

RUN echo "Browser:$BROWSER ${BROWSER}}"

RUN if [ "$BROWSER" = "Chrome" ]; then \
      wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add - && \
      echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list && \
      apt-get update && \
      apt-get install -y google-chrome-stable; \
    elif [ "$BROWSER" = "Firefox" ]; then \
      echo "deb http://deb.debian.org/debian/ stable main" >> /etc/apt/sources.list.d/debian.list && \
      apt-get update && \
      apt-get install -y firefox-esr; \
    fi

# Másolja a projekt forráskódját a konténerbe
COPY . .

# Futtassa a teszteket shellben
ENTRYPOINT python3 -m robot -d results -v BROWSER:$BROWSER -V ./resources/common_variables.py tests
CMD []