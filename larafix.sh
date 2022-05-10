#!/bin/bash

# MIT License

# Copyright (c) 2022 Devon Thomassen

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

help() {
  echo -e "${GREEN}Help menu:${NC}"
  echo -e "By default this script executes the following artisan commands \n${PURPLE}optimize${NC}, ${PURPLE}migrate:fresh --seed${NC} and ${PURPLE}serve${NC}\n"
  echo -e "To execute commands, use the following flags:"
  echo -e "${CYAN}Help${NC}: \t\t[-h | --help | help]\t\t Help command"
  echo -e "${CYAN}Clear${NC}: \t\t[-c | --clear | clear]\t\t Manual clears (routes, config, view and cache)"
  echo -e "${CYAN}Drop${NC}: \t\t[-d | --drop | drop]\t\t Drops all tables"
  echo -e "${CYAN}Dumpimize${NC}: \t[--dump | dump]\t\t\t Executes composer dump-autoload and artisan optimize command"
  echo -e "${CYAN}Migrate${NC}: \t[-m | --migrate | migrate]\t Drops the database and create it again + seeding"
  echo -e "${CYAN}Serve${NC}: \t\t[-s | --serve | serve]\t\t Serve the application"
  echo -e "${CYAN}Wipe${NC}: \t\t[-w | --wipe | wipe]\t\t Drops all tables"
  echo -e "\nYou can combine flags as the following example:"
  echo -e "Example: \t$ bash larafix.sh -dump -s"
  echo -e "This example will execute ${PURPLE}composer dump-autoload${NC}, ${PURPLE}artisan optimize${NC} and ${PURPLE}artisan serve${NC}"
}

# Default function
# Executes the following artisan commands: optimize, migrate:fresh --seed and serve
default() {
  php artisan optimize
  migrate
  serve
}

clear() {
  php artisan route:clear
  php artisan config:clear
  php artisan view:clear
  php artisan cache:clear
}

drop() {
  php artisan db:wipe
}

dumpimize() {
  composer dump-autoload
  php artisan optimize
}

migrate() {
  php artisan migrate:fresh --seed
}

serve() {
  php artisan serve
}

echo
if [ $# -eq 0 ];
then
  default
else
  while [[ $# -gt 0 ]]; do
    case "$1" in
      -h|--help | help)
      help
      exit 0
      ;;
    -m|--migrate | migrate)
      migrate
      shift
      ;;
    -s|--serve | serve)
      serve
      shift
      ;;
    -d |--drop | drop | -w | --wipe | wipe)
      drop
      shift
      ;;
    --dump | dump)
      dumpimize
      shift
      ;;
    -c|--clear | clear)
      clear
      shift
      ;;
    *)
      echo "Invalid option: $1"
      break
      ;;
    esac
  done
fi
