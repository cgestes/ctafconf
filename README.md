# CTAFCONF

Ctafconf is a Zsh configuration. It is full featured, and can be used without more configuration.
It provides good completion and a nice prompt.

## Installation
The ctafconf should be installed in ~/.config/ctafconf. Install it using git.
The master branch is kept as stable as possible.

### Prefered GIT installation
```sh
> mkdir .config
> cd .config
> git clone git://github.com/cgestes/ctafconf.git
> cd ctafconf/bin
> ./ct-installconf
> nano ~/.config/ctafconf/user-profile.sh
```

### Font
Nerd font can be used to have a better experience.
TODO: document it.

## Updates

To update your configuration just `git pull`, or extract newer files over the previous one.
That's all, you dont need to call ct-installconf or ct-updateconf, it's automatic

Using git:
>cd .config/ctafconf
>git pull
That's all, the next time you launch your shell, the ctafconf will be updated

using a newer tarball:
unpack the tarball in .config
>cd .config/
>tar xvzf ctafconf-DATE.tgz



## ZSH

- ctrl-c in completion menu go back to the text previously enterred
- up/down search through history (start typing then up/down to see what i mean)
- pageup/pagedown cycle through history (it does not care about what is already on the command line)
- ctrl-x h call the man for the first word on the command line
- ctrl-x e edit the current command line in your editor
- ctrl-x w display the location of the current command
- ctrl-x c calculator

## HELP
It's a good framework to create our own personnal configuration

|tool           | description  |
|---------------| ------------ |
| findr         | recursive find |
| grepr         | recursive grep with color |
| replacer      | recursive find and replace in all files in the current folder |
| rpurge        | cleanup temporary file (#*, *~) |
| rpurge_c      | cleanup c compiled object (*.o) |
| rpurge_cmake  | cleanup cmake generated makefiles (Makefile, CMakeCache.txt, ..) |
| rpurge_svn    | cleanup svn files (.svn) |
| rpurge_python | cleanup python files (*.pyc, *.pyo) |
| rpurge_cvs    | cleanup cvs files (.cvs) |

## Credits

Some of thoses configurations files have been collected, modified
and enhanced from a lot's of files from differents places.
thanks for all peoples who share configs on the web.

thanks for Sergio Talens-Oliag <sto@debian.org> for his ssft library
thanks for all people GPL code has been 'stolen' from ;-)


## About
Cedric GESTES (cedric.gestes@gmail.com)


```
 _____________________________________
< CTAFCONF? yuhh? MeuuuuuuuuuHHHHHHHH >
 -------------------------------------
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||
```
