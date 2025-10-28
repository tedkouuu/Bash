#!/bin/bash
# websetup.sh - Install Apache on Ubuntu and deploy a Tooplate template

PACKAGE_MANAGER="apt"
REQUIRED_PACKAGES="wget unzip apache2"
WEB_SERVICE_NAME="apache2"
STAGING_DIRECTORY="/tmp/webfiles"
DOCUMENT_ROOT="/var/www/html"
TEMPLATE_ZIP_URL="https://www.tooplate.com/zip-templates/2098_health.zip"
TEMPLATE_ZIP_FILE="$(basename "$TEMPLATE_ZIP_URL")"
TEMPLATE_DIRECTORY="${TEMPLATE_ZIP_FILE%.zip}"

# 1) Install needed tools and Apache
sudo ${PACKAGE_MANAGER} update -y
sudo ${PACKAGE_MANAGER} install -y ${REQUIRED_PACKAGES}

# 2) Start and enable Apache to run on boot
sudo systemctl start ${WEB_SERVICE_NAME}
sudo systemctl enable ${WEB_SERVICE_NAME}

# 3) Prepare a temp workspace
mkdir -p "${STAGING_DIRECTORY}"
cd "${STAGING_DIRECTORY}"

# 4) Download and extract the template
wget "${TEMPLATE_ZIP_URL}"
unzip -o "${TEMPLATE_ZIP_FILE}"

# 5) Copy template files
sudo cp -r "${TEMPLATE_DIRECTORY}/"* "${DOCUMENT_ROOT}/"

# 6) Restart Apache to pick up changes
sudo systemctl restart ${WEB_SERVICE_NAME}

# 7) Cleanup
rm -rf "${STAGING_DIRECTORY}"

echo "Deployment complete. Open http://<server-ip>/ in your browser."
