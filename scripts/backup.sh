#!/usr/bin/env bash
set -euo pipefail

CONTAINER_NAME="devops_postgres"
DB_NAME="booking_engine"
DB_USER="postgres"
BACKUP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/backups"
TIMESTAMP="$(date +"%Y%m%d_%H%M%S")"
BACKUP_FILE="${BACKUP_DIR}/${DB_NAME}_${TIMESTAMP}.sql.gz"

mkdir -p "${BACKUP_DIR}"

echo "Starting Database Backup: ${DB_NAME}"
echo "Target: ${BACKUP_FILE}"

if ! docker ps --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
    echo "ERROR: Target container '${CONTAINER_NAME}' is not running." >&2
    exit 1
fi

docker exec -e PGPASSWORD=postgrespassword "${CONTAINER_NAME}" \
    pg_dump -U "${DB_USER}" -d "${DB_NAME}" --clean --if-exists --no-owner --no-privileges \
    | gzip > "${BACKUP_FILE}"

if [[ -s "${BACKUP_FILE}" ]]; then
    FILE_SIZE=$(du -h "${BACKUP_FILE}" | cut -f1)
    echo "Backup completed successfully: ${BACKUP_FILE} (${FILE_SIZE})"
else
    echo "ERROR: Backup file was created but is empty." >&2
    rm -f "${BACKUP_FILE}"
    exit 1
fi
