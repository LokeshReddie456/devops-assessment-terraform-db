#!/usr/bin/env bash
set -euo pipefail

CONTAINER_NAME="devops_postgres"
DB_NAME="booking_engine"
DB_USER="postgres"
BACKUP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/backups"

if [[ $# -ge 1 ]]; then
    RESTORE_FILE="$1"
else
    RESTORE_FILE=$(ls -t "${BACKUP_DIR}"/*.sql.gz 2>/dev/null | head -n 1 || true)
fi

if [[ -z "${RESTORE_FILE}" \vert{}\vert{} ! -f "${RESTORE_FILE}" ]]; then
    echo "ERROR: No valid backup file found to restore." >&2
    echo "Usage: $0 [path/to/backup.sql.gz]" >&2
    exit 1
fi

echo "Starting Database Restore"
echo "Source:    ${RESTORE_FILE}"

if ! docker ps --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
    echo "ERROR: Target container '${CONTAINER_NAME}' is not running." >&2
    exit 1
fi

gunzip -c "${RESTORE_FILE}" | docker exec -i -e PGPASSWORD=postgrespassword "${CONTAINER_NAME}" \
    psql -U "${DB_USER}" -d "${DB_NAME}" --quiet > /dev/null

echo "Restore operation finished. Verifying data integrity..."

docker exec -i -e PGPASSWORD=postgrespassword "${CONTAINER_NAME}" \
    psql -U "${DB_USER}" -d "${DB_NAME}" -t -A -c "
        SELECT 'hotel_bookings count: ' || count(*) FROM hotel_bookings;
        SELECT 'booking_events count: ' || count(*) FROM booking_events;
    "

echo "Data verification completed successfully."
