# How to create a vim-ale plugin

A simple, Hello World-style tutorial for how to create a `vim-ale` plugin,
including formatter, linter, and/or LSP server (Language Server Protocol).

```sh
vi ./example.hello.txt
```

<img width="602" alt="vim-ale-hello-world in action" src="https://github.com/BeyondCodeBootcamp/vim-ale-hello-world/assets/122831/7e37a08b-d1c1-45a1-99b2-23b51daebe1c">

In this tutorial / example project we have:

| `hellolang`  | A fictional language for this example (`*.hello.txt`) |
| ------------ | ----------------------------------------------------- |
| `hello-fmt`  | The formatter; What `vim-ale` calls a "fixer"         |
| `hello-lint` | The linter with LSP support                           |

# Table of Contents

- [HelloLang Demo](#demo)
- [Anatomy of a vim-ale plugin](#anatomy)
- [A Short Intro to VimScript](#vimscript)
- [The Language Server Protocol](#the-protocol)

# Demo

1. Install `vim-ale-hello-world` to `~/.vim/pack/plugin/start/`
   ```sh
   git clone --depth=1 \
       https://github.com/beyondcodebootcamp/vim-ale-hello-world.git \
       ~/.vim/pack/plugins/start/vim-ale-hello-world
   ```
2. Update `~/.vimrc` to recognize `hellolang`

   ```vim
   let g:ale_fix_on_save = 1
   let g:ale_lint_on_save = 1

   let g:ale_fixers = {
   \  'hellolang': ['hellofmt'],
   \}

   " NOTE: generally you don't need manual linter config
   " let g:ale_linters = {
   " \  'hellolang': ['hellolint'],
   " \}
   ```

3. Install [`node`](https://webinstall.dev/node) and the `hello-lint` Language
   Server
   ```sh
   curl https://webi.sh/node | sh
   ```
   ```sh
   pushd ~/.vim/pack/plugins/start/vim-ale-hello-world/
   npm ci
   ```
4. Update your `PATH` to include `hello-fmt` and `hello-lint` at
   `~/.vim/pack/plugins/start/vim-ale-hello-world/bin/`
   ```sh
   export PATH="$HOME/.vim/pack/plugins/start/vim-ale-hello-world/bin/:$PATH"
   ```

Now `*.hello.txt` is registered as `hellolang` which using `hello-fmt` as a
_fixer_, `hello-lint` as a _linter_ (and for LSP), and `javascript` for _syntax
highlighting_ (because custom syntax highlighting is outside the scope of this
tutorial).

You can try opening and saving (`:w`) a file to watch the magic happen:

```sh
vi ./example.hello.txt
```

```vim
:w
```

```text
// Needs more Hello, World!
```

# Anatomy

There are **TWO** possible configurations for a plugin:

## Internal

An internal plugin is a **Pull Request** to `vim-ale`:

```text
~/
├── bin/
│   ├── hello-fmt
│   └── hello-lint
│
└── .vim/
    ├── pack/plugins/start/ale/
    │   │
    │   ├── ale_linters/hellolang/
    │   │   └── hello_lint.vim
    │   │
    │   └── autoload/ale/
    │       ├── fix/
    │       │   └── registry.vim
    │       └── fixers/
    │           └── hello_fmt.vim
    │
    └── plugins/
        └── hellolang.vim
```

## External

The advantage of an external plugin is that you don't have to get your plugin
into "core" in order for others to use it.

THIS plugin is external (obviously `vim-ale` wouldn't want our demo language in
core).

```text
~/
├── bin/
│   ├── hello-fmt
│   └── hello-lint
│
└── .vim/
    ├── pack/plugins/start/vim-ale-hello-world/
    │   │
    │   ├── ale_linters/hellolang/
    │   │   └── hello_lint.vim
    │   │
    │   ├── autoload/hello_world/fixers/
    │   │   └── hello_fmt.vim
    │   │
    │   └── plugin/
    │       └── hello_world.vim
    │
    └── plugins/
        └── hellolang.vim
```

# VimScript

Here's the minimum you need to know about vimscript to create a plugin:

- special directories
  - autoload
  - plugin
- functions & paths
- variables & scope

## The `autoload` Directory

The `autoload` directory will LAZY LOAD functions when they are called.

## The `plugin` Directory

Vim files in `plugin` will _always_ load as soon as `vim` starts.

## Functions & Paths

1. A function declaration looks like this:
   ```vim
   function! hello_world#fixers#hello_fmt#GetExecutable(buffer) abort
     " ...
   endfunction
   ```
   - `function` means _declare_ and `function!` means declare or _replace_
   - The function name is `GetExecutable`.
   - The function _path_ is `hello_world#fixers#hello_fmt`.
   - File and function paths MUST use `_` (underscore) rather than `-` (hyphen)
2. A function invocation looks like this:
   ```vim
   call hello_world#fixers#hello_fmt#GetExecutable(buffer)
   ```
3. If the function is not defined at the time it is called, _autoload_ will
   attempt to find it by translating its function path to a file path:

   ```text
   Function Path: hello_world#fixers#hello_fmt#GetExecutable

   Plugin Root:  ~/.vim/pack/plugins/start/vim-ale-hello-world/

   Fixer Path:   ./autoload/ale/fixers/hello_fmt.vim
   ```

## Variables & Scope

There are some special scope prefixes. The prefixes allow you to reuse the same
name in different scopes or contexts.

- `a:foo` refers to a function argument (even if it was declared as 'foo')
- `let g:foo = 'bar'` refers to a global variable (accessible everywhere)
- `let l:foo = 'bar'` refers to a local variable (scoped to a function)
- `function! s:foo()` declares the function local to the current script

## The Protocol

LSP Messages are HTTP-like and

- Start with `Content-Type: <byte-length>`
- Separated by `\r\n`
- Contain a JSON body

LSP has _tonnes_ of features, very few of which are needed by `vim-ale` for
linting.

### Examples

See [./events/](./events/).
