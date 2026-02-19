#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <stack-dir>" >&2
  exit 1
fi

STACK_DIR="$1"
if [[ ! -d "$STACK_DIR" ]]; then
  echo "Stack directory not found: $STACK_DIR" >&2
  exit 1
fi

require_cmd() {
  if ! command -v "$1" >/dev/null 2>&1; then
    echo "Missing dependency: $1" >&2
    exit 1
  fi
}

require_cmd terraform
require_cmd yamllint
require_cmd shellcheck
require_cmd awk

pushd "$STACK_DIR" >/dev/null

echo "[1/6] terraform fmt"
terraform fmt -check -recursive

echo "[2/6] terraform init"
terraform init -backend=false -input=false >/tmp/terraform-init.log

echo "[3/6] terraform validate"
terraform validate

echo "[4/6] yamllint"
yamllint schema.yaml

echo "[5/6] shellcheck"
if [[ -f cloud-init.tftpl ]]; then
  if rg -q '#!/usr/bin/env bash|#!/bin/bash' cloud-init.tftpl; then
    awk '/content: \|/{flag=1;next}/^runcmd:/{flag=0}flag{sub(/^      /,"");print}' cloud-init.tftpl > /tmp/bootstrap-rendered.sh
    shellcheck -e SC2016 -x /tmp/bootstrap-rendered.sh
  else
    echo "No embedded shell script detected in cloud-init template; skipping shellcheck on template body"
  fi
fi

popd >/dev/null

echo "[6/6] package smoke test"
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
"$ROOT_DIR/scripts/package-stack.sh" "$STACK_DIR" /tmp/stack-smoke-test.zip >/tmp/package.log

echo "Validation passed"
