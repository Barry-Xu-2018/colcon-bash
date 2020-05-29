# generated from colcon_bash/shell/template/prefix_chain.bash.em

# This script extends the environment with the environment of other prefix
# paths which were sourced when this file was generated as well as all packages
# contained in this prefix path.

# function to source another script with conditional trace output
# first argument: the path of the script
_colcon_prefix_chain_bash_source_script() {
  if [ -f "$1" ]; then
    if [ -n "$COLCON_TRACE" ]; then
      echo ". \"$1\""
    fi
    . "$1"
  else
    echo "not found: \"$1\"" 1>&2
  fi
}

ENV_CACHE_FILE="$HOME/.ros/env.cache"
ENV_CACHE_LOCK_FILE="$HOME/.ros/.env.cache.lock"

mkdir -p $(dirname "$ENV_CACHE_FILE")

@[if chained_prefix_path]@

# source chained prefixes
@[  for prefix in reversed(chained_prefix_path)]@
# setting COLCON_CURRENT_PREFIX avoids determining the prefix in the sourced script
COLCON_CURRENT_PREFIX="@(prefix)"

# If .env.cache.lock is locked, env.cache is being made. So cannot use it.
if $(flock -n -x "$ENV_CACHE_LOCK_FILE" true) && [ -f "${ENV_CACHE_FILE}" ]; then
  _cached_ordered_commands=$(cat "${ENV_CACHE_FILE}")
  eval "$_cached_ordered_commands"
  unset _colcon_prefix_sh_source_script
  echo "Use cached environmnet !"
  echo "If you want to update cached environment, please remove \"${ENV_CACHE_FILE}\" !"
  echo "And re-execute \". ${BASH_SOURCE[0]}\" in new terminal."
else
  _colcon_prefix_chain_bash_source_script "$COLCON_CURRENT_PREFIX/@(prefix_script_no_ext).bash"
fi
@[  end for]@
@[end if]@

# source this prefix
# setting COLCON_CURRENT_PREFIX avoids determining the prefix in the sourced script
COLCON_CURRENT_PREFIX="$(builtin cd "`dirname "${BASH_SOURCE[0]}"`" > /dev/null && pwd)"

# If .env.cache.lock is locked, env.cache is being made. So cannot use it.
if $(flock -n -x "$ENV_CACHE_LOCK_FILE" true) && [ -f "${ENV_CACHE_FILE}" ]; then
  _cached_ordered_commands=$(cat "${ENV_CACHE_FILE}")
  eval "$_cached_ordered_commands"
  unset _colcon_prefix_sh_source_script
  echo "Use cached environmnet !"
  echo "If you want to update cached environment, please remove \"${ENV_CACHE_FILE}\" !"
  echo "And re-execute \". ${BASH_SOURCE[0]}\" in new terminal."
else
  _colcon_prefix_chain_bash_source_script "$COLCON_CURRENT_PREFIX/@(prefix_script_no_ext).bash"
fi

unset ENV_CACHE_FILE
unset ENV_CACHE_LOCK_FILE
unset COLCON_CURRENT_PREFIX
unset _colcon_prefix_chain_bash_source_script
