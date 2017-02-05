# http://sgeb.io/posts/2014/04/zsh-zle-custom-widgets/

# CUTBUFFER: the last item cut using one of the ‘kill-’ commands; the string which the next yank would insert in the line. Later entries in the kill ring are in the array killring

# widget for killing line, and piping it from the kill ring to pbcopy
function copy-kill-whole-line {
  zle kill-whole-line
  echo -n $CUTBUFFER | pbcopy
}
zle -N copy-kill-whole-line

# `^` for `ctrl` and `\e` for `alt`
bindkey '^p' copy-kill-whole-line
bindkey '\ep' copy-kill-whole-line


bindkey '\e^[[A' select-a-word

# widget for selecting a region, or copying and killing the selected region
function select-copy-kill-region {
  if [ "$REGION_ACTIVE" -eq "0" ]; then
    zle select-a-word
  else
    zle kill-region
    echo -n $CUTBUFFER | pbcopy
    zle yank
  fi
}
zle -N select-copy-kill-region

bindkey '\e^[[B' select-copy-kill-region
