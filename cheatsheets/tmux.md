
# tmux

- [Tutorial](https://leimao.github.io/blog/Tmux-Tutorial/)
- [Cheatsheet](https://tmuxcheatsheet.com)
- [Plugin manager](https://github.com/tmux-plugins/tpm)
- Install Tmux resurrect


commands can be run from host terminal or in tmux console

host console

```
$ tmux new
```

tmux console

```
:new
```

enter tmux console via `C-b :`


### commands

##### new session

`tmux new [-s session-name]`

```
:new-session
:new
:n
```


##### list sessions

```
:list-sessions
:ls
```


##### rename sessions

`tmux rename [-t session-name] new-session-name`


##### kill server

`tmux kill-server`


##### kill session

`tmux kill-session [-t session-name]`


##### attach

```
tmux attach -t session-name
tmux a -t session-name
```


### bindings

all bindings begin with `C-b`

##### sessions

- `d` - detach from session
- `s` - list-sessions
- `$` - rename current session


##### windows

- `c` - create new window
- `&` - kill current window
- `,` - rename current window
- `<digit>` - switch to specific window
- `n` - move to next window
- `p` - move to previous window


##### panes

- `|` - split pane vertically (personally remapped)
- `-` - split pane horizontally (personally remapped)
- `x` - close current pane
- `[hjkl]` - switch between panes in a window (personally remapped)
- `[yuio]` - resize a pane (personally remapped)

