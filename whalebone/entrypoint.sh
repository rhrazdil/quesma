#!/bin/bash
# Exit on any error
set -e

# Set default values if environment variables are not set
export FRONTEND_ELASTICSEARCH_LISTEN_PORT="${FRONTEND_ELASTICSEARCH_LISTEN_PORT:-8080}"
export FRONTEND_ELASTICSEARCH_INGEST_DISABLE_AUTH="${FRONTEND_ELASTICSEARCH_INGEST_DISABLE_AUTH:-true}"

export BACKEND_ELASTICSEARCH_URL="${BACKEND_ELASTICSEARCH_URL:-http://elasticsearch:9200}"
export BACKEND_ELASTICSEARCH_ADMIN_URL="${BACKEND_ELASTICSEARCH_ADMIN_URL:-http://localhost:5601}"
export BACKEND_ELASTICSEARCH_USER="${BACKEND_ELASTICSEARCH_USER:-}"
export BACKEND_ELASTICSEARCH_PASSWORD="${BACKEND_ELASTICSEARCH_PASSWORD:-}"

export BACKEND_CLICKHOUSE_URL="${BACKEND_CLICKHOUSE_URL:-clickhouse://clickhouse:9000}"
export BACKEND_CLICKHOUSE_ADMIN_URL="${BACKEND_CLICKHOUSE_ADMIN_URL:-http://localhost:8123/play}"
export BACKEND_CLICKHOUSE_DATABASE="${BACKEND_CLICKHOUSE_DATABASE:-passivedns}"
export BACKEND_CLICKHOUSE_USER="${BACKEND_CLICKHOUSE_USER:-default}"
export BACKEND_CLICKHOUSE_PASSWORD="${BACKEND_CLICKHOUSE_PASSWORD:-}"

# Define file paths
TEMPLATE_FILE="/config/starter-config.yml.template"
OUTPUT_FILE="/config/starter-config.yml"

# Substitute environment variables into the template to create the final config
/usr/bin/envsubst < "${TEMPLATE_FILE}" > "${OUTPUT_FILE}"

export QUESMA_CONFIG_FILE="${OUTPUT_FILE}"

exec ./quesma/bin
