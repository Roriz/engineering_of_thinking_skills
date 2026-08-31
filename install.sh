#!/usr/bin/env bash
#
# install.sh - Links skills from this repository into AI agent environments
#
# Target directories:
#   - ~/.agents/skills
#   - ~/.claude/skills
#   - ~/.gemini/config/skills
#   - ~/.codex/skills (if ~/.codex exists)

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILLS_DIR="${SCRIPT_DIR}/skills"

TARGET_DIRS=(
  "${HOME}/.agents/skills"
  "${HOME}/.claude/skills"
  "${HOME}/.gemini/config/skills"
)

# Include ~/.codex/skills if ~/.codex exists
if [ -d "${HOME}/.codex" ]; then
  TARGET_DIRS+=("${HOME}/.codex/skills")
fi

echo "=================================================="
echo "Installing Engineering of Thinking Skills"
echo "Source: ${SKILLS_DIR}"
echo "=================================================="

for target in "${TARGET_DIRS[@]}"; do
  mkdir -p "${target}"
  echo ""
  echo "Target: ${target}"

  # Prune broken or removed repo symlinks
  for existing in "${target}"/*; do
    [ -L "${existing}" ] || continue
    target_link="$(readlink -f "${existing}" || true)"
    if [[ "${target_link}" == "${SKILLS_DIR}"/* ]] && [ ! -d "${target_link}" ]; then
      echo "  [PRUNED] Removing stale symlink $(basename "${existing}")"
      rm -f "${existing}"
    fi
  done

  # Link active skills
  for skill_path in "${SKILLS_DIR}"/*; do
    [ -d "${skill_path}" ] || continue
    skill_name="$(basename "${skill_path}")"
    dest="${target}/${skill_name}"

    # Replace existing directory/symlink cleanly
    if [ -e "${dest}" ] || [ -L "${dest}" ]; then
      rm -rf "${dest}"
    fi

    ln -s "${skill_path}" "${dest}"
    echo "  [OK] ${skill_name} -> ${dest}"
  done
done

echo ""
echo "Installation complete! All skills symlinked successfully."
