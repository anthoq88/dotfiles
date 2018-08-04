
fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

e() {
  kak -c default $@ || kak -s default $@
}

#Aliases
alias r=ranger
alias finder=open
alias lisp='rlwrap sbcl'
alias tmux="TERM=screen-256color-bce tmux"
alias tree="tree -I 'node_modules|__assets__'"

alias gcm=_gitcommitwithbranch
alias gpo='git push origin '
alias gs='git status'
alias ga='git add'
alias gaa='git add .'
alias gc='git checkout'
alias gcb='git checkout -b'
alias cljslein='rlwrap lein'
alias smlr='rlwrap sml'
alias racketrl='rlwrap racket'
alias schemerl='rlwrap scheme'
alias ocamlrl='rlwrap ocaml'
alias prolog='swipl'

alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"
alias firefox="/Applications/Firefox.app/Contents/MacOS/firefox"

alias k='f -e kak'


export PYTHONSTARTUP=~/.pythonrc
export EDITOR=kak
export DEVELOPMENT=$HOME/Development

export PYTHON2_PATH=$(python3 -m site --user-base)/bin
export PYTHON3_PATH=$(python3 -m site --user-base)/bin
export PATH=$PATH:/Users/anthonyquizon/.cargo/bin:/Users/anthonyquizon/.local/bin:/usr/local/bin:/usr/local/sbin:$PYTHON3_PATH:$PYTHON2_PATH

eval "$(fasd --init auto)"

[ -z "$TMUX"  ] && exec `tmux attach`
