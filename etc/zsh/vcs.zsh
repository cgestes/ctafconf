# vim:ft=zsh ts=2 sw=2 sts=2 et fenc=utf-8
################################################################
# vcs
# This file holds supplemental VCS functions
# for the powerlevel9k-ZSH-theme
# https://github.com/bhilburn/powerlevel9k
################################################################

#vcs and icons stolen from powerlevel9k

# vim:ft=zsh ts=2 sw=2 sts=2 et fenc=utf-8
################################################################
# icons
# This file holds the icon definitions and
# icon-functions for the powerlevel9k-ZSH-theme
# https://github.com/bhilburn/powerlevel9k
################################################################

# These characters require the Powerline fonts to work properly. If you see
# boxes or bizarre characters below, your fonts are not correctly installed. If
# you do not want to install a special font, you can set `POWERLEVEL9K_MODE` to
# `compatible`. This shows all icons in regular symbols.

# Initialize the icon list according to the user's `POWERLEVEL9K_MODE`.
typeset -gAH icons
case $POWERLEVEL9K_MODE in
  'flat'|'awesome-patched')
    # Awesome-Patched Font required! See:
    # https://github.com/gabrielelana/awesome-terminal-fonts/tree/patching-strategy/patched
    # Set the right locale to protect special characters
    local LC_ALL="" LC_CTYPE="en_US.UTF-8"
    icons=(
      LEFT_SEGMENT_SEPARATOR         $'\uE0B0'              # 
      RIGHT_SEGMENT_SEPARATOR        $'\uE0B2'              # 
      LEFT_SEGMENT_END_SEPARATOR     ' '                    # Whitespace
      LEFT_SUBSEGMENT_SEPARATOR      $'\uE0B1'              # 
      RIGHT_SUBSEGMENT_SEPARATOR     $'\uE0B3'              # 
      CARRIAGE_RETURN_ICON           $'\u21B5'              # ↵
      ROOT_ICON                      $'\uE801'              # 
      RUBY_ICON                      $'\uE847 '             # 
      AWS_ICON                       $'\uE895'              # 
      AWS_EB_ICON                    $'\U1F331 '            # 🌱
      BACKGROUND_JOBS_ICON           $'\uE82F '             # 
      TEST_ICON                      $'\uE891'              # 
      TODO_ICON                      $'\u2611'              # ☑
      BATTERY_ICON                   $'\uE894'              # 
      DISK_ICON                      $'\uE1AE '             # 
      OK_ICON                        $'\u2713'              # ✓
      FAIL_ICON                      $'\u2718'              # ✘
      SYMFONY_ICON                   'SF'
      NODE_ICON                      $'\u2B22'              # ⬢
      MULTILINE_FIRST_PROMPT_PREFIX  $'\u256D'$'\U2500'
      MULTILINE_SECOND_PROMPT_PREFIX $'\u2570'$'\U2500 '
      APPLE_ICON                     $'\uE26E'              # 
      FREEBSD_ICON                   $'\U1F608 '            # 😈
      ANDROID_ICON                   $'\uE270'              # 
      LINUX_ICON                     $'\uE271'              # 
      SUNOS_ICON                     $'\U1F31E '            # 🌞
      HOME_ICON                      $'\uE12C'              # 
      HOME_SUB_ICON                  $'\uE18D'              # 
      FOLDER_ICON                    $'\uE818'              # 
      NETWORK_ICON                   $'\uE1AD'              # 
      LOAD_ICON                      $'\uE190 '             # 
      SWAP_ICON                      $'\uE87D'              # 
      RAM_ICON                       $'\uE1E2 '             # 
      SERVER_ICON                    $'\uE895'              # 
      VCS_UNTRACKED_ICON             $'\uE16C'              # 
      VCS_UNSTAGED_ICON              $'\uE17C'              # 
      VCS_STAGED_ICON                $'\uE168'              # 
      VCS_STASH_ICON                 $'\uE133 '             # 
      #VCS_INCOMING_CHANGES_ICON     $'\uE1EB '             # 
      #VCS_INCOMING_CHANGES_ICON     $'\uE80D '             # 
      VCS_INCOMING_CHANGES_ICON      $'\uE131 '             # 
      #VCS_OUTGOING_CHANGES_ICON     $'\uE1EC '             # 
      #VCS_OUTGOING_CHANGES_ICON     $'\uE80E '             # 
      VCS_OUTGOING_CHANGES_ICON      $'\uE132 '             # 
      VCS_TAG_ICON                   $'\uE817 '             # 
      VCS_BOOKMARK_ICON              $'\uE87B'              # 
      VCS_COMMIT_ICON                $'\uE821 '             # 
      VCS_BRANCH_ICON                $'\uE220'              # 
      VCS_REMOTE_BRANCH_ICON         $'\u2192'              # →
      VCS_GIT_ICON                   $'\uE20E '             # 
      VCS_GIT_GITHUB_ICON            $'\uE20E '             #
      VCS_GIT_BITBUCKET_ICON         $'\uE20E '             #
      VCS_GIT_GITLAB_ICON            $'\uE20E '             #
      VCS_HG_ICON                    $'\uE1C3 '             # 
      VCS_SVN_ICON                   '(svn) '
      RUST_ICON                      ''
      PYTHON_ICON                    $'\U1F40D'             # 🐍
      SWIFT_ICON                     ''
      GO_ICON                        ''
      PUBLIC_IP_ICON                 ''
      LOCK_ICON                      $'\UE138'              # 
      EXECUTION_TIME_ICON            $'\UE89C'              # 
      SSH_ICON                       '(ssh)'
    )
  ;;
  'awesome-fontconfig')
    # fontconfig with awesome-font required! See
    # https://github.com/gabrielelana/awesome-terminal-fonts
    # Set the right locale to protect special characters
    local LC_ALL="" LC_CTYPE="en_US.UTF-8"
    icons=(
      LEFT_SEGMENT_SEPARATOR         $'\uE0B0'              # 
      RIGHT_SEGMENT_SEPARATOR        $'\uE0B2'              # 
      LEFT_SEGMENT_END_SEPARATOR     ' '                    # Whitespace
      LEFT_SUBSEGMENT_SEPARATOR      $'\uE0B1'              # 
      RIGHT_SUBSEGMENT_SEPARATOR     $'\uE0B3'              # 
      CARRIAGE_RETURN_ICON           $'\u21B5'              # ↵
      ROOT_ICON                      $'\uF201'              # 
      RUBY_ICON                      $'\uF219 '             # 
      AWS_ICON                       $'\uF270'              # 
      AWS_EB_ICON                    $'\U1F331 '            # 🌱
      BACKGROUND_JOBS_ICON           $'\uF013 '             # 
      TEST_ICON                      $'\uF291'              # 
      TODO_ICON                      $'\u2611'              # ☑
      BATTERY_ICON                   $'\U1F50B'             # 🔋
      DISK_ICON                      $'\uF0A0 '             # 
      OK_ICON                        $'\u2713'              # ✓
      FAIL_ICON                      $'\u2718'              # ✘
      SYMFONY_ICON                   'SF'
      NODE_ICON                      $'\u2B22'              # ⬢
      MULTILINE_FIRST_PROMPT_PREFIX  $'\u256D'$'\U2500'     # ╭─
      MULTILINE_SECOND_PROMPT_PREFIX $'\u2570'$'\U2500 '    # ╰─
      APPLE_ICON                     $'\uF179'              # 
      FREEBSD_ICON                   $'\U1F608 '            # 😈
      ANDROID_ICON                   $'\uE17B'              # 
      LINUX_ICON                     $'\uF17C'              # 
      SUNOS_ICON                     $'\uF185 '             # 
      HOME_ICON                      $'\uF015'              # 
      HOME_SUB_ICON                  $'\uF07C'              # 
      FOLDER_ICON                    $'\uF115'              # 
      NETWORK_ICON                   $'\uF09E'              # 
      LOAD_ICON                      $'\uF080 '             # 
      SWAP_ICON                      $'\uF0E4'              # 
      RAM_ICON                       $'\uF0E4'              # 
      SERVER_ICON                    $'\uF233'              # 
      VCS_UNTRACKED_ICON             $'\uF059'              # 
      VCS_UNSTAGED_ICON              $'\uF06A'              # 
      VCS_STAGED_ICON                $'\uF055'              # 
      VCS_STASH_ICON                 $'\uF01C '             # 
      VCS_INCOMING_CHANGES_ICON      $'\uF01A '             # 
      VCS_OUTGOING_CHANGES_ICON      $'\uF01B '             # 
      VCS_TAG_ICON                   $'\uF217 '             # 
      VCS_BOOKMARK_ICON              $'\uF27B'              # 
      VCS_COMMIT_ICON                $'\uF221 '             # 
      VCS_BRANCH_ICON                $'\uF126'              # 
      VCS_REMOTE_BRANCH_ICON         $'\u2192'              # →
      VCS_GIT_ICON                   $'\uF1D3 '             # 
      VCS_GIT_GITHUB_ICON            $'\uF113 '             # 
      VCS_GIT_BITBUCKET_ICON         $'\uF171 '             # 
      VCS_GIT_GITLAB_ICON            $'\uF296 '             # 
      VCS_HG_ICON                    $'\uF0C3 '             # 
      VCS_SVN_ICON                   '(svn) '
      RUST_ICON                      $'\uE6A8'              # 
      PYTHON_ICON                    $'\U1F40D'             # 🐍
      SWIFT_ICON                     ''
      GO_ICON                        ''
      PUBLIC_IP_ICON                 ''
      LOCK_ICON                      $'\UE138'              # 
      EXECUTION_TIME_ICON            $'\uF253'
      SSH_ICON                       '(ssh)'
    )
  ;;
  'nerdfont-complete'|'nerdfont-fontconfig')
    # nerd-font patched (complete) font required! See
    # https://github.com/ryanoasis/nerd-fonts
    # Set the right locale to protect special characters
    local LC_ALL="" LC_CTYPE="en_US.UTF-8"
    icons=(
      LEFT_SEGMENT_SEPARATOR         $'\uE0B0'              # 
      RIGHT_SEGMENT_SEPARATOR        $'\uE0B2'              # 
      LEFT_SEGMENT_END_SEPARATOR     ' '                    # Whitespace
      LEFT_SUBSEGMENT_SEPARATOR      $'\uE0B1'              # 
      RIGHT_SUBSEGMENT_SEPARATOR     $'\uE0B3'              # 
      CARRIAGE_RETURN_ICON           $'\u21B5'              # ↵
      ROOT_ICON                      $'\uE614 '             # 
      RUBY_ICON                      $'\uF219 '             # 
      AWS_ICON                       $'\uF270'              # 
      AWS_EB_ICON                    $'\UF1BD  '            # 
      BACKGROUND_JOBS_ICON           $'\uF013 '             # 
      TEST_ICON                      $'\uF188'              # 
      TODO_ICON                      $'\uF133'              # 
      BATTERY_ICON                   $'\UF240 '             # 
      DISK_ICON                      $'\uF0A0'              # 
      OK_ICON                        $'\uF00C'              # 
      FAIL_ICON                      $'\uF00D'              # 
      SYMFONY_ICON                   $'\uE757'              # 
      NODE_ICON                      $'\uE617 '             # 
      MULTILINE_FIRST_PROMPT_PREFIX  $'\u256D'$'\U2500'     # ╭─
      MULTILINE_SECOND_PROMPT_PREFIX $'\u2570'$'\U2500 '    # ╰─
      APPLE_ICON                     $'\uF179'              # 
      FREEBSD_ICON                   $'\UF30E '             # 
      ANDROID_ICON                   $'\uF17B'              # 
      LINUX_ICON                     $'\uF17C'              # 
      SUNOS_ICON                     $'\uF185 '             # 
      HOME_ICON                      $'\uF015'              # 
      HOME_SUB_ICON                  $'\uF07C'              # 
      FOLDER_ICON                    $'\uF115'              # 
      NETWORK_ICON                   $'\uF1EB'              # 
      LOAD_ICON                      $'\uF080 '             # 
      SWAP_ICON                      $'\uF464'              # 
      RAM_ICON                       $'\uF0E4'              # 
      SERVER_ICON                    $'\uF0AE'              # 
      VCS_UNTRACKED_ICON             $'\uF059'              # 
      VCS_UNSTAGED_ICON              $'\uF06A'              # 
      VCS_STAGED_ICON                $'\uF055'              # 
      VCS_STASH_ICON                 $'\uF01C '             # 
      VCS_INCOMING_CHANGES_ICON      $'\uF01A '             # 
      VCS_OUTGOING_CHANGES_ICON      $'\uF01B '             # 
      VCS_TAG_ICON                   $'\uF02B '             # 
      VCS_BOOKMARK_ICON              $'\uF461 '             # 
      VCS_COMMIT_ICON                $'\uE729 '             # 
      VCS_BRANCH_ICON                $'\uF126 '             # 
      VCS_REMOTE_BRANCH_ICON         $'\uE728 '             # 
      VCS_GIT_ICON                   $'\uF113 '             # 
      VCS_GIT_GITHUB_ICON            $'\uE709 '             # 
      VCS_GIT_BITBUCKET_ICON         $'\uE703 '             # 
      VCS_GIT_GITLAB_ICON            $'\uF296 '             # 
      VCS_HG_ICON                    $'\uF0C3 '             # 
      VCS_SVN_ICON                   $'\uE72D '             # 
      RUST_ICON                      $'\uE7A8 '             # 
      PYTHON_ICON                    $'\UE73C '             # 
      SWIFT_ICON                     $'\uE755'              # 
      GO_ICON                        $'\uE626'              # 
      PUBLIC_IP_ICON                 $'\UF0AC'              # 
      LOCK_ICON                      $'\UF023'              # 
      EXECUTION_TIME_ICON            $'\uF252'              # 
      SSH_ICON                       $'\uF489'              # 
    )
  ;;
  *)
    # Powerline-Patched Font required!
    # See https://github.com/Lokaltog/powerline-fonts
    # Set the right locale to protect special characters
    local LC_ALL="" LC_CTYPE="en_US.UTF-8"
    icons=(
      LEFT_SEGMENT_SEPARATOR         $'\uE0B0'              # 
      RIGHT_SEGMENT_SEPARATOR        $'\uE0B2'              # 
      LEFT_SEGMENT_END_SEPARATOR     ' '                    # Whitespace
      LEFT_SUBSEGMENT_SEPARATOR      $'\uE0B1'              # 
      RIGHT_SUBSEGMENT_SEPARATOR     $'\uE0B3'              # 
      CARRIAGE_RETURN_ICON           $'\u21B5'              # ↵
      ROOT_ICON                      $'\u26A1'              # ⚡
      RUBY_ICON                      ''
      AWS_ICON                       'AWS:'
      AWS_EB_ICON                    $'\U1F331 '            # 🌱
      BACKGROUND_JOBS_ICON           $'\u2699'              # ⚙
      TEST_ICON                      ''
      TODO_ICON                      $'\u2611'              # ☑
      BATTERY_ICON                   $'\U1F50B'             # 🔋
      DISK_ICON                      $'hdd '
      OK_ICON                        $'\u2713'              # ✓
      FAIL_ICON                      $'\u2718'              # ✘
      SYMFONY_ICON                   'SF'
      NODE_ICON                      $'\u2B22'              # ⬢
      MULTILINE_FIRST_PROMPT_PREFIX  $'\u256D'$'\u2500'
      MULTILINE_SECOND_PROMPT_PREFIX $'\u2570'$'\u2500 '
      APPLE_ICON                     'OSX'
      FREEBSD_ICON                   'BSD'
      ANDROID_ICON                   'And'
      LINUX_ICON                     'Lx'
      SUNOS_ICON                     'Sun'
      HOME_ICON                      ''
      HOME_SUB_ICON                  ''
      FOLDER_ICON                    ''
      NETWORK_ICON                   'IP'
      LOAD_ICON                      'L'
      SWAP_ICON                      'SWP'
      RAM_ICON                       'RAM'
      SERVER_ICON                    ''
      VCS_UNTRACKED_ICON             '?'
      VCS_UNSTAGED_ICON              $'\u25CF'              # ●
      VCS_STAGED_ICON                $'\u271A'              # ✚
      VCS_STASH_ICON                 $'\u235F'              # ⍟
      VCS_INCOMING_CHANGES_ICON      $'\u2193'              # ↓
      VCS_OUTGOING_CHANGES_ICON      $'\u2191'              # ↑
      VCS_TAG_ICON                   ''
      VCS_BOOKMARK_ICON              $'\u263F'              # ☿
      VCS_COMMIT_ICON                ''
      VCS_BRANCH_ICON                $'\uE0A0'              # 
      VCS_REMOTE_BRANCH_ICON         $'\u2192'              # →
      VCS_GIT_ICON                   ''
      VCS_GIT_GITHUB_ICON            ''
      VCS_GIT_BITBUCKET_ICON         ''
      VCS_GIT_GITLAB_ICON            ''
      VCS_HG_ICON                    ''
      VCS_SVN_ICON                   ''
      RUST_ICON                      ''
      PYTHON_ICON                    ''
      SWIFT_ICON                     'Swift'
      GO_ICON                        'Go'
      PUBLIC_IP_ICON                 ''
      LOCK_ICON                      $'\UE0A2'
      EXECUTION_TIME_ICON            'Dur'
      SSH_ICON                       '(ssh)'
    )
  ;;
esac

# Override the above icon settings with any user-defined variables.
case $POWERLEVEL9K_MODE in
  'flat')
    # Set the right locale to protect special characters
    local LC_ALL="" LC_CTYPE="en_US.UTF-8"
    icons[LEFT_SEGMENT_SEPARATOR]=''
    icons[RIGHT_SEGMENT_SEPARATOR]=''
    icons[LEFT_SUBSEGMENT_SEPARATOR]='|'
    icons[RIGHT_SUBSEGMENT_SEPARATOR]='|'
  ;;
  'compatible')
    # Set the right locale to protect special characters
    local LC_ALL="" LC_CTYPE="en_US.UTF-8"
    icons[LEFT_SEGMENT_SEPARATOR]=$'\u2B80'                 # ⮀
    icons[RIGHT_SEGMENT_SEPARATOR]=$'\u2B82'                # ⮂
    icons[VCS_BRANCH_ICON]='@'
  ;;
esac

if [[ "$POWERLEVEL9K_HIDE_BRANCH_ICON" == true ]]; then
    icons[VCS_BRANCH_ICON]=''
fi

# Safety function for printing icons
# Prints the named icon, or if that icon is undefined, the string name.
function print_icon() {
  local icon_name=$1
  local ICON_USER_VARIABLE=POWERLEVEL9K_${icon_name}
  echo -n "${icons[$icon_name]}"
}

# Get a list of configured icons
#   * $1 string - If "original", then the original icons are printed,
#                 otherwise "print_icon" is used, which takes the users
#                 overrides into account.
get_icon_names() {
  # Iterate over a ordered list of keys of the icons array
  for key in ${(@kon)icons}; do
    echo -n "POWERLEVEL9K_$key: "
    if [[ "${1}" == "original" ]]; then
      # print the original icons as they are defined in the array above
      echo "${icons[$key]}"
    else
      # print the icons as they are configured by the user
      echo "$(print_icon "$key")"
    fi
  done
}















set POWERLEVEL9K_VCS_SHOW_SUBMODULE_DIRTY true
function +vi-git-untracked() {
    # TODO: check git >= 1.7.2 - see function git_compare_version()
    local FLAGS
    FLAGS=('--porcelain')

    if [[ "$POWERLEVEL9K_VCS_SHOW_SUBMODULE_DIRTY" == "false" ]]; then
      FLAGS+='--ignore-submodules=dirty'
    fi

    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' && \
            -n $(git status ${FLAGS} | grep -E '^\?\?' 2> /dev/null | tail -n1) ]]; then
        hook_com[unstaged]+=" $(print_icon 'VCS_UNTRACKED_ICON')"
        VCS_WORKDIR_HALF_DIRTY=true
    else
        VCS_WORKDIR_HALF_DIRTY=false
    fi
}

function +vi-git-aheadbehind() {
    local ahead behind branch_name
    local -a gitstatus

    branch_name=$(git symbolic-ref --short HEAD 2>/dev/null)

    # for git prior to 1.7
    # ahead=$(git rev-list origin/${branch_name}..HEAD | wc -l)
    ahead=$(git rev-list "${branch_name}"@{upstream}..HEAD 2>/dev/null | wc -l)
    (( ahead )) && gitstatus+=( " $(print_icon 'VCS_OUTGOING_CHANGES_ICON')${ahead// /}" )

    # for git prior to 1.7
    # behind=$(git rev-list HEAD..origin/${branch_name} | wc -l)
    behind=$(git rev-list HEAD.."${branch_name}"@{upstream} 2>/dev/null | wc -l)
    (( behind )) && gitstatus+=( " $(print_icon 'VCS_INCOMING_CHANGES_ICON')${behind// /}" )

    hook_com[misc]+=${(j::)gitstatus}
}

function +vi-git-remotebranch() {
    local remote branch_name

    # Are we on a remote-tracking branch?
    remote=${$(git rev-parse --verify HEAD@{upstream} --symbolic-full-name 2>/dev/null)/refs\/(remotes|heads)\/}
    branch_name=$(git symbolic-ref --short HEAD 2>/dev/null)

    hook_com[branch]="$(print_icon 'VCS_BRANCH_ICON')${hook_com[branch]}"
    # Always show the remote
    #if [[ -n ${remote} ]] ; then
    # Only show the remote if it differs from the local
    if [[ -n ${remote} ]] && [[ "${remote#*/}" != "${branch_name}" ]] ; then
        hook_com[branch]+="$(print_icon 'VCS_REMOTE_BRANCH_ICON')${remote// /}"
    fi
}

set POWERLEVEL9K_VCS_HIDE_TAGS false
function +vi-git-tagname() {
    if [[ "$POWERLEVEL9K_VCS_HIDE_TAGS" == "false" ]]; then
        # If we are on a tag, append the tagname to the current branch string.
        local tag
        tag=$(git describe --tags --exact-match HEAD 2>/dev/null)

        if [[ -n "${tag}" ]] ; then
            # There is a tag that points to our current commit. Need to determine if we
            # are also on a branch, or are in a DETACHED_HEAD state.
            if [[ -z $(git symbolic-ref HEAD 2>/dev/null) ]]; then
                # DETACHED_HEAD state. We want to append the tag name to the commit hash
                # and print it. Unfortunately, `vcs_info` blows away the hash when a tag
                # exists, so we have to manually retrieve it and clobber the branch
                # string.
                local revision
                revision=$(git rev-list -n 1 --abbrev-commit --abbrev=${POWERLEVEL9K_VCS_INTERNAL_HASH_LENGTH} HEAD)
                hook_com[branch]="$(print_icon 'VCS_BRANCH_ICON')${revision} $(print_icon 'VCS_TAG_ICON')${tag}"
            else
                # We are on both a tag and a branch; print both by appending the tag name.
                hook_com[branch]+=" $(print_icon 'VCS_TAG_ICON')${tag}"
            fi
        fi
    fi
}

# Show count of stashed changes
# Port from https://github.com/whiteinge/dotfiles/blob/5dfd08d30f7f2749cfc60bc55564c6ea239624d9/.zsh_shouse_prompt#L268
function +vi-git-stash() {
  local -a stashes

  if [[ -s $(git rev-parse --git-dir)/refs/stash ]] ; then
    stashes=$(git stash list 2>/dev/null | wc -l)
    hook_com[misc]+=" $(print_icon 'VCS_STASH_ICON')${stashes// /}"
  fi
}

function +vi-hg-bookmarks() {
  if [[ -n "${hgbmarks[@]}" ]]; then
    hook_com[hg-bookmark-string]=" $(print_icon 'VCS_BOOKMARK_ICON')${hgbmarks[@]}"

    # To signal that we want to use the sting we just generated, set the special
    # variable `ret' to something other than the default zero:
    ret=1
    return 0
  fi
}

function +vi-vcs-detect-changes() {
  if [[ "${hook_com[vcs]}" == "git" ]]; then

    local remote=$(git ls-remote --get-url 2> /dev/null)
    if [[ "$remote" =~ "github" ]] then
      vcs_visual_identifier='VCS_GIT_GITHUB_ICON'
    elif [[ "$remote" =~ "bitbucket" ]] then
      vcs_visual_identifier='VCS_GIT_BITBUCKET_ICON'
    elif [[ "$remote" =~ "gitlab" ]] then
      vcs_visual_identifier='VCS_GIT_GITLAB_ICON'
    else
      vcs_visual_identifier='VCS_GIT_ICON'
    fi

  elif [[ "${hook_com[vcs]}" == "hg" ]]; then
    vcs_visual_identifier='VCS_HG_ICON'
  elif [[ "${hook_com[vcs]}" == "svn" ]]; then
    vcs_visual_identifier='VCS_SVN_ICON'
  fi

  if [[ -n "${hook_com[staged]}" ]] || [[ -n "${hook_com[unstaged]}" ]]; then
    VCS_WORKDIR_DIRTY=true
  else
    VCS_WORKDIR_DIRTY=false
  fi
}

function +vi-svn-detect-changes() {
  local svn_status="$(svn status)"
  if [[ -n "$(echo "$svn_status" | grep \^\?)" ]]; then
    hook_com[unstaged]+=" $(print_icon 'VCS_UNTRACKED_ICON')"
    VCS_WORKDIR_HALF_DIRTY=true
  fi
  if [[ -n "$(echo "$svn_status" | grep \^\M)" ]]; then
    hook_com[unstaged]+=" $(print_icon 'VCS_UNSTAGED_ICON')"
    VCS_WORKDIR_DIRTY=true
  fi
  if [[ -n "$(echo "$svn_status" | grep \^\A)" ]]; then
    hook_com[staged]+=" $(print_icon 'VCS_STAGED_ICON')"
    VCS_WORKDIR_DIRTY=true
  fi
}
