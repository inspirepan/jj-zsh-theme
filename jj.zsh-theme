# jj.zsh-theme - A minimal prompt with jj/git support
#
# Features:
# - Line 1: path + vcs info (jj preferred, git fallback)
# - Line 2: prompt character
# - Shows change_id, description, +/- stats, git user

_jj_theme_vcs_info() {
  local git_user=""
  if git rev-parse --is-inside-work-tree &>/dev/null; then
    git_user=" %F{green}$(git config user.name)%f"
  fi

  # Try jj first
  if jj root &>/dev/null; then
    local change_id desc ins del stat_line
    change_id=$(jj log -r @ --no-graph -T 'change_id.shortest(8)' 2>/dev/null)
    desc=$(jj log -r @ --no-graph -T 'description.first_line()' 2>/dev/null)
    stat_line=$(jj diff --stat -r @ 2>/dev/null | tail -1)
    ins=$(echo "$stat_line" | grep -oE '[0-9]+ insertion' | grep -oE '[0-9]+')
    del=$(echo "$stat_line" | grep -oE '[0-9]+ deletion' | grep -oE '[0-9]+')

    local stat=""
    [[ -n "$ins" || -n "$del" ]] && stat=" %F{green}+${ins:-0}%f %F{red}-${del:-0}%f"

    echo " %F{magenta}jj:${change_id}%f %F{8}${desc}%f${stat}${git_user}"
    return
  fi

  # Fallback to git
  if git rev-parse --is-inside-work-tree &>/dev/null; then
    local branch ins del stat_line
    branch=$(git branch --show-current 2>/dev/null)
    [[ -z "$branch" ]] && branch=$(git rev-parse --short HEAD 2>/dev/null)
    stat_line=$(git diff --stat HEAD 2>/dev/null | tail -1)
    ins=$(echo "$stat_line" | grep -oE '[0-9]+ insertion' | grep -oE '[0-9]+')
    del=$(echo "$stat_line" | grep -oE '[0-9]+ deletion' | grep -oE '[0-9]+')

    local stat=""
    [[ -n "$ins" || -n "$del" ]] && stat=" %F{green}+${ins:-0}%f %F{red}-${del:-0}%f"

    echo " %F{cyan}git:${branch}%f${stat}${git_user}"
    return
  fi
}

setopt PROMPT_SUBST

PROMPT='%F{blue}%~%f$(_jj_theme_vcs_info)
%F{magenta}❯%f '
