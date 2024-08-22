# ~/.profile: executed by Bourne-compatible login shells.

# IF ZSH exist use it, else use bash
if [ "$ZSH" ]; then
  if [ -f ~/.zshrc ]; then
    . ~/.zshrc
  fi
elif [ "$BASH" ]; then
  if [ -f ~/.bashrc ]; then
    . ~/.bashrc
  fi
fi

mesg n 2> /dev/null || true