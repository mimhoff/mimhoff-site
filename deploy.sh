#!/bin/bash

# Full site deployment script
# Builds the Astro profile site and deploys everything to Dreamhost
# Usage: ~/mimhoff-site/deploy.sh

set -e

# Configuration
SERVER="pdx1-shared-a1-35.dreamhost.com"
USERNAME="mimhoff"
REMOTE_ROOT="mimhoff.com"
REMOTE_WORDLOCK="mimhoff.com/wordlock"
REMOTE_DUCKTTT="mimhoff.com/duck-tictactoe"
REMOTE_CHAIN4="mimhoff.com/chain-4"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ASTRO_DIR="${SCRIPT_DIR}/astro-site"
GAMES_DIR="${SCRIPT_DIR}/mimhoff-games"

GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}================================${NC}"
echo -e "${BLUE}mimhoff.com deployment${NC}"
echo -e "${BLUE}================================${NC}"
echo ""

# Step 1: Build Astro site
echo -e "${GREEN}Step 1: Building Astro site...${NC}"
cd "$ASTRO_DIR"
npm run build
echo -e "${GREEN}✓ Build complete${NC}"
echo ""

# Step 2: Deploy Astro dist/ to root
# Exclude game subdirectories — those are deployed separately below
echo -e "${GREEN}Step 2: Deploying profile site to root...${NC}"
rsync -avz --delete \
    --chmod=D755,F644 \
    --exclude 'wordlock/' \
    --exclude 'duck-tictactoe/' \
    --exclude 'chain-4/' \
    --exclude 'shared-game-components/' \
    "${ASTRO_DIR}/dist/" ${USERNAME}@${SERVER}:${REMOTE_ROOT}/
echo -e "${GREEN}✓ Profile site deployed${NC}"
echo ""

# Step 3: Sync game icons
echo -e "${GREEN}Step 3: Syncing game icons...${NC}"
cp "${GAMES_DIR}/wordlock/icons/icon-512x512.png"    "${GAMES_DIR}/site/icons/wordlock-icon.png"
cp "${GAMES_DIR}/duck-tictactoe/icons/icon-web-512.png" "${GAMES_DIR}/site/icons/duck-tictactoe-icon.png"
cp "${GAMES_DIR}/chain-4/icons/icon-512x512.png"     "${GAMES_DIR}/site/icons/chain-4-icon.png"
echo -e "${GREEN}✓ Icons synced${NC}"
echo ""

# Step 4: Deploy shared game components
echo -e "${GREEN}Step 4: Deploying shared game components...${NC}"
rsync -avz --delete \
    --chmod=D755,F644 \
    "${GAMES_DIR}/shared-game-components/" ${USERNAME}@${SERVER}:${REMOTE_ROOT}/shared-game-components/
echo -e "${GREEN}✓ Shared components deployed${NC}"
echo ""

# Step 5: Deploy WordLock
echo -e "${GREEN}Step 5: Deploying WordLock...${NC}"
rsync -avz --delete \
    --chmod=D755,F644 \
    --exclude 'node_modules/' \
    --exclude 'android/' \
    --exclude 'ios/' \
    --exclude 'www/' \
    --exclude 'docs/' \
    --exclude '.git/' \
    --exclude '.gitignore' \
    --exclude 'package.json' \
    --exclude 'package-lock.json' \
    --exclude 'capacitor.config.json' \
    --exclude 'landing.html' \
    --exclude 'deploy.sh' \
    --exclude 'DEPLOYMENT.md' \
    --exclude 'play-store-assets/' \
    --exclude '*.keystore' \
    --exclude '*.jks' \
    --exclude 'keystore-info.txt' \
    "${GAMES_DIR}/wordlock/" ${USERNAME}@${SERVER}:${REMOTE_WORDLOCK}/
echo -e "${GREEN}✓ WordLock deployed${NC}"
echo ""

# Step 6: Deploy Duck Tic-Tac-Toe
echo -e "${GREEN}Step 6: Deploying Duck Tic-Tac-Toe...${NC}"
rsync -avz --delete \
    --chmod=D755,F644 \
    --exclude 'node_modules/' \
    --exclude 'android/' \
    --exclude 'www/' \
    --exclude '.git/' \
    --exclude '.gitignore' \
    --exclude '.claude/' \
    --exclude 'package.json' \
    --exclude 'package-lock.json' \
    --exclude 'capacitor.config.json' \
    --exclude 'build-apk.sh' \
    --exclude 'deploy-to-windows.sh' \
    --exclude '*.py' \
    --exclude '__pycache__/' \
    --exclude 'CLAUDE.md' \
    --exclude 'README.md' \
    --exclude 'ANALYSIS_GUIDE.md' \
    --exclude 'GAME_ANALYSIS.md' \
    --exclude 'icon-source.svg' \
    "${GAMES_DIR}/duck-tictactoe/" ${USERNAME}@${SERVER}:${REMOTE_DUCKTTT}/
echo -e "${GREEN}✓ Duck Tic-Tac-Toe deployed${NC}"
echo ""

# Step 7: Deploy Chain 4
echo -e "${GREEN}Step 7: Deploying Chain 4...${NC}"
rsync -avz --delete \
    --chmod=D755,F644 \
    --exclude 'node_modules/' \
    --exclude 'android/' \
    --exclude 'www/' \
    --exclude '.git/' \
    --exclude '.gitignore' \
    --exclude '.claude/' \
    --exclude 'package.json' \
    --exclude 'package-lock.json' \
    --exclude 'capacitor.config.json' \
    --exclude 'build-apk.sh' \
    --exclude '*.py' \
    --exclude '__pycache__/' \
    --exclude 'CLAUDE.md' \
    --exclude 'README.md' \
    --exclude 'icon-source.svg' \
    "${GAMES_DIR}/chain-4/" ${USERNAME}@${SERVER}:${REMOTE_CHAIN4}/
echo -e "${GREEN}✓ Chain 4 deployed${NC}"
echo ""

echo -e "${BLUE}================================${NC}"
echo -e "${GREEN}Deployment complete!${NC}"
echo -e "${BLUE}================================${NC}"
echo ""
echo "Live at:"
echo "  https://mimhoff.com"
echo "  https://mimhoff.com/wordlock"
echo "  https://mimhoff.com/duck-tictactoe"
echo "  https://mimhoff.com/chain-4"
