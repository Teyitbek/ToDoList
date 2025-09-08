#!/bin/sh

#  Sentry.sh

if which sentry-cli >/dev/null; then
export SENTRY_AUTH_TOKEN=1dd0c1b7690c45ca947941225c35a2e056dc82952f794e699f100aae2ffcdffb
ERROR=$(sentry-cli upload-dif "$DWARF_DSYM_FOLDER_PATH" 2>&1 >/dev/null)
if [ ! $? -eq 0 ]; then
echo "warning: sentry-cli - $ERROR"
fi
else
echo "warning: sentry-cli not installed, download from https://github.com/getsentry/sentry-cli/releases"
fi
