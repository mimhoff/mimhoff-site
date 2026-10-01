#!/bin/bash

# mimhoff.com deployment script
# Builds the Astro profile site and the games, then rsyncs each build to Dreamhost.
#
# Usage: ./deploy.sh [--dry-run] [site] [wordlock] [duck]
#   No targets = deploy everything.
#   --dry-run  build and test as normal, but only show what rsync would change.
#
# Chain 4 and shared-game-components are still live on the server but have no local
# source any more; this script leaves them untouched.

set -euo pipefail

# Configuration
SERVER="pdx1-shared-a1-35.dreamhost.com"
USERNAME="mimhoff"
REMOTE_ROOT="mimhoff.com"
REMOTE_WORDLOCK="mimhoff.com/wordlock"
REMOTE_DUCKTTT="mimhoff.com/duck-tictactoe"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ASTRO_DIR="${SCRIPT_DIR}/astro-site"
GAMES_DIR="$(cd "${SCRIPT_DIR}/../../games" && pwd)"

GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

RSYNC_OPTS=(-avz --delete --chmod=D755,F644)
TARGETS=()
for arg in "$@"; do
    case "$arg" in
        --dry-run|-n) RSYNC_OPTS+=(--dry-run) ;;
        site|wordlock|duck) TARGETS+=("$arg") ;;
        *) echo -e "${RED}Unknown argument: $arg${NC}"; echo "Usage: $0 [--dry-run] [site] [wordlock] [duck]"; exit 1 ;;
    esac
done
[ ${#TARGETS[@]} -eq 0 ] && TARGETS=(site wordlock duck)

wants() { [[ " ${TARGETS[*]} " == *" $1 "* ]]; }

# Test and build a Vite game, then rsync its dist/ (not the source) to the server.
# --delete removes files left over from older versions (e.g. WordLock v2's js/ and words.js).
deploy_game() {
    local name="$1" dir="$2" remote="$3"
    echo -e "${GREEN}Deploying ${name}...${NC}"
    cd "$dir"
    [ -d node_modules ] || npm ci
    npm test
    npm run build
    if [ ! -f dist/index.html ] || [ ! -f dist/sw.js ]; then
        echo -e "${RED}✗ ${name}: dist/ is missing index.html or sw.js, not deploying${NC}"
        exit 1
    fi
    rsync "${RSYNC_OPTS[@]}" dist/ "${USERNAME}@${SERVER}:${remote}/"
    echo -e "${GREEN}✓ ${name} deployed${NC}"
    echo ""
}

echo -e "${BLUE}================================${NC}"
echo -e "${BLUE}mimhoff.com deployment: ${TARGETS[*]}${NC}"
[[ " ${RSYNC_OPTS[*]} " == *" --dry-run "* ]] && echo -e "${BLUE}(dry run: nothing will be uploaded)${NC}"
echo -e "${BLUE}================================${NC}"
echo ""

if wants site; then
    echo -e "${GREEN}Building and deploying profile site...${NC}"
    cd "$ASTRO_DIR"
    npm run build
    # Game subdirectories are excluded so --delete doesn't remove them
    rsync "${RSYNC_OPTS[@]}" \
        --exclude 'wordlock/' \
        --exclude 'duck-tictactoe/' \
        --exclude 'chain-4/' \
        --exclude 'shared-game-components/' \
        "${ASTRO_DIR}/dist/" "${USERNAME}@${SERVER}:${REMOTE_ROOT}/"
    echo -e "${GREEN}✓ Profile site deployed${NC}"
    echo ""
fi

wants wordlock && deploy_game "WordLock" "${GAMES_DIR}/wordlock" "$REMOTE_WORDLOCK"
wants duck && deploy_game "Duck Tic-Tac-Toe" "${GAMES_DIR}/duck-tictactoe" "$REMOTE_DUCKTTT"

echo -e "${BLUE}================================${NC}"
echo -e "${GREEN}Deployment complete!${NC}"
echo -e "${BLUE}================================${NC}"
echo ""
echo "Live at:"
wants site && echo "  https://mimhoff.com"
wants wordlock && echo "  https://mimhoff.com/wordlock"
wants duck && echo "  https://mimhoff.com/duck-tictactoe"
exit 0
