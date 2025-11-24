
function! CustomOpts() abort
  let [l:info, l:loc] = ale#util#FindItemAtCursor(bufnr(''))
  if (has_key(l:loc, 'linter_name'))
	let result = {'title': ' ALE: ' . (l:loc.linter_name) . ' '}
  else
	let result = {'title': ' Definition '}
  endif
  return result
endfunction

let g:ale_linters = {'python': ['bandit', 'mypy', 'ruff']}
let g:ale_python_pylsp_executable = 'pyls'
let g:ale_cursor_detail=1
let g:ale_detail_to_floating_preview=1
let g:ale_floating_preview=1
let g:ale_lint_on_enter=0
let g:ale_lint_on_save=1
let g:ale_lint_on_text_changed=0
let g:ale_floating_preview_popup_opts = 'g:CustomOpts'
let g:ale_floating_window_border = ['│', '─', '╭', '╮', '╯', '╰', '│', '─']
let g:ale_lsp_suggestions=1
let g:ale_warn_about_trailing_blank_lines=0
let g:ale_warn_about_trailing_whitespace=0
let g:ale_virtualtext_cursor = 'disabled'
let g:ale_python_ruff_options='--ignore E501 --ignore I001'
let g:ale_python_ruff_use_config='$HOME/.ruff.toml'

set foldmethod=indent

let $PYTHONPATH .= ';' . '/Users/jamiemcmillan/Documents/Development/'
