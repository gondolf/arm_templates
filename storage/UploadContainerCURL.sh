#!/bin/bash

DATE_NOW=$(date -Ru | sed 's/\+0000/GMT/')
AZ_VERSION="2018-03-28"
AZ_BLOB_URL="https://staccinftab01.blob.core.windows.net"
AZ_BLOB_CONTAINER="logs-backupstatusreport"
AZ_BLOB_TARGET="${AZ_BLOB_URL}/${AZ_BLOB_CONTAINER}/"
AZ_SAS_TOKEN="sp=racwdl&st=2021-05-11T18:25:12Z&se=2024-01-01T02:25:12Z&sv=2020-02-10&sr=c&sig=H8Symr7XRnIo5dk%2F0KYWaR30FJHPPivgBcCatJQ4Aw8%3D"

curl -v -X PUT -H "Content-Type: application/octet-stream" -H "x-ms-date: ${DATE_NOW}" -H "x-ms-version: ${AZ_VERSION}" -H "x-ms-blob-type: BlockBlob" --data-binary "test.log" "${AZ_BLOB_TARGET}test.log${AZ_SAS_TOKEN}"
