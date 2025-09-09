#!/usr/bin/env bash
set -euo pipefail

# 👉 CHANGE THESE if your template placeholder is not "yatzee"
OLD_KEBAB="yatzee"   # e.g. appears in README, package.json, shadow-cljs.edn, namespaces
OLD_SNAKE="yatzee"   # e.g. directory name under src/main, src/test, etc.

APP_KEBAB="${APP_KEBAB:?APP_KEBAB not set}"   # e.g. "my-new-app"
APP_SNAKE="${APP_SNAKE:?APP_SNAKE not set}"   # e.g. "my_new_app"
OWNER_LOGIN="${OWNER_LOGIN:-}"
OWNER_NAME="${OWNER_NAME:-$OWNER_LOGIN}"
APP_DESCRIPTION="${APP_DESCRIPTION:-"Awesome $APP_KEBAB created by $OWNER_LOGIN"}"

# Optional token placeholders you can use in files (recommended):
# yatzee, yatzee, A yatzee, Cobbiac, Cobbiac

echo "🔧 Replacing content:"
echo "  ${OLD_KEBAB}  -> ${APP_KEBAB}"
echo "  ${OLD_SNAKE}  -> ${APP_SNAKE}"
echo "  __APP_* tokens -> concrete values"

# Replace in tracked text files only
# (avoids .git, node_modules, jars, images, etc.)
if git ls-files -z >/dev/null 2>&1; then
  git ls-files -z | xargs -0 \
  sed -i \
    -e "s/${OLD_KEBAB//\//\\/}/${APP_KEBAB//\//\\/}/g" \
    -e "s/${OLD_SNAKE//\//\\/}/${APP_SNAKE//\//\\/}/g" \
    -e "s/yatzee/${APP_KEBAB//\//\\/}/g" \
    -e "s/yatzee/${APP_SNAKE//\//\\/}/g" \
    -e "s/A yatzee/${APP_DESCRIPTION//\//\\/}/g" \
    -e "s/Cobbiac/${OWNER_LOGIN//\//\\/}/g" \
    -e "s/Cobbiac/${OWNER_NAME//\//\\/}/g"
else
  echo "No tracked files found; skipping replacements."
fi

echo "📁 Renaming namespace directories where present…"
# Common Clojure(Script) layouts—add/remove as needed
for base in src/main src/test src test src/cljs resources/src; do
  [ -d "$base/$OLD_SNAKE" ] && { git mv "$base/$OLD_SNAKE" "$base/$APP_SNAKE" 2>/dev/null || mv "$base/$OLD_SNAKE" "$base/$APP_SNAKE"; }
  [ -d "$base/$OLD_KEBAB" ] && { git mv "$base/$OLD_KEBAB" "$base/$APP_SNAKE" 2>/dev/null || mv "$base/$OLD_KEBAB" "$base/$APP_SNAKE"; }
done

echo "🧹 Disabling repeated initialization…"
rm -f .github/template.yml

echo "✅ Rename complete."
