call plug#begin()
" Here comes the plugins
Plug 'x4m3/vim-epitech'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'romgrk/barbar.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'dense-analysis/ale'
Plug 'EdenEast/nightfox.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'sindrets/diffview.nvim'
Plug 'preservim/nerdcommenter'
Plug 'lewis6991/gitsigns.nvim'
Plug 'startup-nvim/startup.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/completion-nvim'
Plug 'emilienlemaire/clang-tidy.nvim'
" main one
Plug 'github/copilot.vim'
" 9000+ Snippets
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
" or                                , { 'branch': '0.1.x' }
" Required
Plug 'neovim/nvim-lsp'
" Plugin
Plug 'robert-oleynik/clangd-nvim'
" lua & third party sources -- See https://github.com/ms-jpq/coq.thirdparty
" Need to **configure separately**

Plug 'ms-jpq/coq.thirdparty', {'branch': '3p'}
" - shell repl
" - nvim lua api
" - scientific calculator
" - comment banner
" - etc
Plug 'daa84/neovim-lib'

" emoji completion
Plug 'xiyaowong/telescope-emoji.nvim'

call plug#end()

set completeopt=menu,menuone,noselect


lua << EOF

local local_roots = { "/../include/*.h", "/../../include/*.h", "/../../../include/*.h" }

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
require'lspconfig'.clangd.setup{
   capabilities = capabilities,
   cmd = { 'clangd', '--background-index' },
   filetypes = { 'c', 'cpp' },
   root_dir = require'lspconfig'.util.root_pattern('.git', 'compile_commands.json', '.'),
   settings = {
      clangd = {
         excludeArgs = { "-frounding-math" },
         suggestMissingIncludes = true,
         suggestMissingFunctions = true,
         suggestMissingPrototypes = true,
         crossFileRename = true,
         backgroundIndex = true,
         logFile = "/tmp/clangd.log",
         pchStorage = "memory",
         completionStyle = "detailed",
         semanticHighlighting = true,
         headerInsertion = "iwyu",
         renameCallbacks = true,
      },
   },
}

vim.api.nvim_set_keymap('i', '<C-Space>', 'coc#refresh()', { noremap = true, silent = true, expr = true })
vim.api.nvim_set_keymap('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', { noremap = true, silent = true, expr = true })
vim.api.nvim_set_keymap('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<S-Tab>"', { noremap = true, silent = true, expr = true })

root_dir = function(fname)
   return require'lspconfig'.util.root_pattern('.git', 'compile_commands.json', '.', 'include')(fname) or vim.fn.getcwd()
end

require("coq_3p") {
  { src = "nvimlua", short_name = "nLUA" },
  { src = "vimtex",  short_name = "vTEX" },
  { src = "copilot", short_name = "COP", accept_key = "<c-f>" },
  { src = "demo" },
}

require("nvim-treesitter.configs").setup {
  ensure_installed = "c", "cpp", "python", "javascript", "html", "css", "lua",
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}

require("nvim-web-devicons").setup {
  override = {
    -- A
    a = { icon = "🅰️", color = "#888888", name = "A" },
    ai = { icon = "🖌️", color = "#FBBF24", name = "Ai" },
    apk = { icon = "📱", color = "#A4C639", name = "Apk" },
    asm = { icon = "⚙️", color = "#6E4C13", name = "Asm" },
    avi = { icon = "🎞️", color = "#A3B1C2", name = "Avi" },
    awk = { icon = "🦉", color = "#4E9A06", name = "Awk" },
    -- B
    bash = { icon = "🐚", color = "#4EAA25", name = "Bash" },
    bat = { icon = "🦇", color = "#C1F12E", name = "Bat" },
    bmp = { icon = "🖼️", color = "#A3B1C2", name = "Bmp" },
    -- C
    c = { icon = "🌐", color = "#555555", name = "C" },
    cab = { icon = "📦", color = "#FFB13B", name = "Cab" },
    cc = { icon = "🌐", color = "#f34b7d", name = "Cc" },
    class = { icon = "🎓", color = "#B07219", name = "Class" },
    clj = { icon = "🦗", color = "#8DC63F", name = "Clj" },
    cljc = { icon = "🦗", color = "#8DC63F", name = "Cljc" },
    cljs = { icon = "🦗", color = "#8DC63F", name = "Cljs" },
    cmake = { icon = "⚙️", color = "#064F8C", name = "Cmake" },
    coffee = { icon = "☕", color = "#6F4E37", name = "Coffee" },
    conf = { icon = "⚙️", color = "#6D8086", name = "Conf" },
    cpp = { icon = "🌐", color = "#f34b7d", name = "Cpp" },
    cs = { icon = "♯", color = "#178600", name = "Cs" },
    css = { icon = "🎨", color = "#563d7c", name = "Css" },
    csv = { icon = "📊", color = "#89e051", name = "Csv" },
    cxx = { icon = "🌐", color = "#f34b7d", name = "Cxx" },
    -- D
    dart = { icon = "🎯", color = "#00B4AB", name = "Dart" },
    db = { icon = "🗄️", color = "#B07219", name = "Db" },
    diff = { icon = "🔄", color = "#41535B", name = "Diff" },
    dll = { icon = "📦", color = "#007ACC", name = "Dll" },
    dmg = { icon = "💿", color = "#A3B1C2", name = "Dmg" },
    doc = { icon = "📄", color = "#185ABD", name = "Doc" },
    docx = { icon = "📄", color = "#185ABD", name = "Docx" },
    dockerfile = { icon = "🐳", color = "#0db7ed", name = "Dockerfile" },
    -- E
    ejs = { icon = "📜", color = "#A91E50", name = "Ejs" },
    elixir = { icon = "💧", color = "#6E4A7E", name = "Elixir" },
    elm = { icon = "🌳", color = "#60B5CC", name = "Elm" },
    erb = { icon = "💎", color = "#701516", name = "Erb" },
    erl = { icon = "🦄", color = "#B83998", name = "Erl" },
    exe = { icon = "💻", color = "#00A2ED", name = "Exe" },
    -- F
    fish = { icon = "🐟", color = "#4CAF50", name = "Fish" },
    flv = { icon = "🎞️", color = "#A3B1C2", name = "Flv" },
    -- G
    gem = { icon = "💎", color = "#701516", name = "Gem" },
    gif = { icon = "🖼️", color = "#FFB6C1", name = "Gif" },
    go = { icon = "🐹", color = "#00ADD8", name = "Go" },
    graphql = { icon = "⚛️", color = "#E10098", name = "Graphql" },
    gz = { icon = "🗜️", color = "#88AADD", name = "Gz" },
    -- H
    h = { icon = "🌐", color = "#A074C4", name = "H" },
    haml = { icon = "🔨", color = "#EDEAE8", name = "Haml" },
    hbs = { icon = "🔨", color = "#FFA500", name = "Hbs" },
    heex = { icon = "💧", color = "#6E4A7E", name = "Heex" },
    hs = { icon = "λ", color = "#5E5086", name = "Hs" },
    html = { icon = "🌐", color = "#E34C26", name = "Html" },
    htm = { icon = "🌐", color = "#E34C26", name = "Htm" },
    -- I
    ico = { icon = "🖼️", color = "#A3B1C2", name = "Ico" },
    ini = { icon = "⚙️", color = "#6D8086", name = "Ini" },
    iso = { icon = "💿", color = "#A3B1C2", name = "Iso" },
    -- J
    java = { icon = "☕", color = "#b07219", name = "Java" },
    javascript = { icon = "🟨", color = "#f1e05a", name = "Javascript" },
    jpeg = { icon = "🖼️", color = "#FFB6C1", name = "Jpeg" },
    jpg = { icon = "🖼️", color = "#FFB6C1", name = "Jpg" },
    js = { icon = "🟨", color = "#f1e05a", name = "Js" },
    json = { icon = "🔧", color = "#cbcb41", name = "Json" },
    jsx = { icon = "⚛️", color = "#61DAFB", name = "Jsx" },
    -- K
    kotlin = { icon = "🚀", color = "#A97BFF", name = "Kotlin" },
    ksh = { icon = "🐚", color = "#4EAA25", name = "Ksh" },
    -- L
    less = { icon = "🎨", color = "#1D365D", name = "Less" },
    lhs = { icon = "λ", color = "#5E5086", name = "Lhs" },
    lua = { icon = "🌘", color = "#000080", name = "Lua" },
    -- M
    makefile = { icon = "🛠️", color = "#427819", name = "Makefile" },
    markdown = { icon = "📝", color = "#083fa1", name = "Markdown" },
    md = { icon = "📝", color = "#083fa1", name = "Md" },
    mjs = { icon = "🟩", color = "#F1E05A", name = "Mjs" },
    mkv = { icon = "🎥", color = "#A3B1C2", name = "Mkv" },
    mp3 = { icon = "🎵", color = "#B2B2B2", name = "Mp3" },
    mp4 = { icon = "🎥", color = "#B2B2B2", name = "Mp4" },
    mpeg = { icon = "🎥", color = "#B2B2B2", name = "Mpeg" },
    mpg = { icon = "🎥", color = "#B2B2B2", name = "Mpg" },
    mustache = { icon = "🧔", color = "#CCA61A", name = "Mustache" },
    -- N
    nginx = { icon = "🔧", color = "#009639", name = "Nginx" },
    nim = { icon = "⚡", color = "#FFC200", name = "Nim" },
    nix = { icon = "❄️", color = "#7EBAFF", name = "Nix" },
    -- O
    o = { icon = "⭕", color = "#888888", name = "O" },
    ogg = { icon = "🎵", color = "#B2B2B2", name = "Ogg" },
    -- P
    pdf = { icon = "📄", color = "#FF0000", name = "Pdf" },
    php = { icon = "🐘", color = "#4F5D95", name = "Php" },
    png = { icon = "🖼️", color = "#A3B1C2", name = "Png" },
    pl = { icon = "🐪", color = "#000000", name = "Pl" },
    ppt = { icon = "📄", color = "#D04423", name = "Ppt" },
    pptx = { icon = "📄", color = "#D04423", name = "Pptx" },
    ps1 = { icon = "📄", color = "#012456", name = "Ps1" },
    psd = { icon = "🖼️", color = "#001E36", name = "Psd" },
    py = { icon = "🐍", color = "#3572A5", name = "Py" },
    python = { icon = "🐍", color = "#3572A5", name = "Python" },
    -- R
    r = { icon = "📈", color = "#198CE7", name = "R" },
    rar = { icon = "🗜️", color = "#7D42F4", name = "Rar" },
    rb = { icon = "💎", color = "#701516", name = "Rb" },
    rs = { icon = "🦀", color = "#dea584", name = "Rs" },
    rpm = { icon = "📦", color = "#FCA121", name = "Rpm" },
    rtf = { icon = "📄", color = "#B31B1B", name = "Rtf" },
    rust = { icon = "🦀", color = "#dea584", name = "Rust" },
    -- S
    sass = { icon = "🎨", color = "#CF649A", name = "Sass" },
    scala = { icon = "🔴", color = "#DC322F", name = "Scala" },
    scss = { icon = "🎨", color = "#CF649A", name = "Scss" },
    sh = { icon = "🐚", color = "#89e051", name = "Sh" },
    sql = { icon = "🗄️", color = "#d0b09f", name = "Sql" },
    swift = { icon = "🐦", color = "#F05138", name = "Swift" },
    svg = { icon = "🖼️", color = "#FFB13B", name = "Svg" },
    -- T
    tar = { icon = "🗜️", color = "#00ACC1", name = "Tar" },
    tex = { icon = "📄", color = "#3D6117", name = "Tex" },
    toml = { icon = "📜", color = "#9c4221", name = "Toml" },
    ts = { icon = "🟦", color = "#007ACC", name = "Ts" },
    tsx = { icon = "🟦", color = "#007ACC", name = "Tsx" },
    txt = { icon = "📄", color = "#89E051", name = "Txt" },
    -- V
    vim = { icon = "🔹", color = "#019833", name = "Vim" },
    vue = { icon = "🟩", color = "#42B883", name = "Vue" },
    -- W
    wav = { icon = "🔊", color = "#B2B2B2", name = "Wav" },
    webm = { icon = "🎥", color = "#A3B1C2", name = "Webm" },
    webp = { icon = "🖼️", color = "#A3B1C2", name = "Webp" },
    -- X
    xml = { icon = "📄", color = "#0060ac", name = "Xml" },
    xls = { icon = "📄", color = "#207245", name = "Xls" },
    xlsx = { icon = "📄", color = "#207245", name = "Xlsx" },
    -- Y
    yaml = { icon = "📄", color = "#cb171e", name = "Yaml" },
    yml = { icon = "📄", color = "#cb171e", name = "Yml" },
    -- Z
    zip = { icon = "🗜️", color = "#000000", name = "Zip" },
    zsh = { icon = "🐚", color = "#89E051", name = "Zsh" },
    zig = { icon = "⚡", color = "#ec915c", name = "Zig" },
    -- Dot files
    [".gitignore"] = { icon = "📁", color = "#F14E32", name = "Gitignore" },
    [".metadata"] = { icon = "📄", color = "#FFB6C1", name = "Metadata" },
    ["CMakeLists.txt"] = { icon = "⚙️", color = "#064F8C", name = "CMakeLists" },
    ["Dockerfile"] = { icon = "🐳", color = "#0db7ed", name = "Dockerfile" },
    ["LICENSE"] = { icon = "📜", color = "#D0D0D0", name = "License" },
    ["Makefile"] = { icon = "🛠️", color = "#427819", name = "Makefile" },
    ["README.md"] = { icon = "📄", color = "#185ABD", name = "Readme" },
    ["docker-compose.yml"] = { icon = "🐳", color = "#0db7ed", name = "DockerCompose" },
    ["yarn.lock"] = { icon = "🔒", color = "#2188b6", name = "YarnLock" },
    ["package.json"] = { icon = "📦", color = "#cb3837", name = "PackageJson" },
    ["package-lock.json"] = { icon = "🔒", color = "#2188b6", name = "PackageLockJson" },
    ["tsconfig.json"] = { icon = "📄", color = "#007ACC", name = "TsConfigJson" },
    ["jsconfig.json"] = { icon = "📄", color = "#f1e05a", name = "JsConfigJson" },
    ["babel.config.json"] = { icon = "📄", color = "#f9dc3e", name = "BabelConfigJson" },
    ["webpack.config.js"] = { icon = "⚙️", color = "#8DD6F9", name = "WebpackConfigJs" },
    ["webpack.config.ts"] = { icon = "⚙️", color = "#8DD6F9", name = "WebpackConfigTs" },
    ["jest.config.js"] = { icon = "🃏", color = "#99424f", name = "JestConfigJs" },
    ["jest.config.ts"] = { icon = "🃏", color = "#99424f", name = "JestConfigTs" },
  },
  renderer = {
    icons = {
      glyphs = {
        default = "📄",
        symlink = "🔗",
        folder = {
          default = "📁",
          open = "📂",
          empty = "📂",
          empty_open = "📂",
          symlink = "🔗",
          symlink_open = "🔗",
        },
        git = {
          unstaged = "📝",
          staged = "✅",
          unmerged = "❗",
          renamed = "🔀",
          untracked = "✨",
          deleted = "🗑️",
          ignored = "🙈",
        },
      },
    },
  },
}

require("gitsigns").setup()
require("nvim-tree").setup()
require("startup").setup({theme = "startify"})
-- Setup language servers.


require("telescope").setup {
  extensions = {
    emoji = {
      action = function(emoji)
        -- argument emoji is a table.
        -- {name="", value="", cagegory="", description=""}

        vim.fn.setreg("*", emoji.value)
        print([[Press p or "*p to paste this emoji]] .. emoji.value)

        -- insert emoji when picked
        -- vim.api.nvim_put({ emoji.value }, 'c', false, true)
      end,
    }
  },
}
require('nightfox').setup({
  options = {
    -- Compiled file's destination location
    compile_path = vim.fn.stdpath("cache") .. "/nightfox",
    compile_file_suffix = "_compiled", -- Compiled file suffix
    transparent = false,    -- Disable setting background
    terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
    dim_inactive = false,   -- Non focused panes set to alternative background
    styles = {              -- Style to be applied to different syntax groups
      comments = "NONE",    -- Value is any valid attr-list value `:help attr-list`
      conditionals = "NONE",
      constants = "NONE",
      functions = "NONE",
      keywords = "NONE",
      numbers = "NONE",
      operators = "NONE",
      strings = "NONE",
      types = "NONE",
      variables = "NONE",
    },
    inverse = {             -- Inverse highlight for different types
      match_paren = false,
      visual = false,
      search = false,
    },
    modules = {             -- List of various plugins and additional options
      -- ...
    },
  },
  palettes = {},
  specs = {},
  groups = {},
})

vim.opt.list = true
vim.opt.listchars:append "space:⋅"
vim.opt.listchars:append "eol:↴"

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- setup must be called before loading
vim.cmd("colorscheme dayfox")

-- Unless you are still migrating, remove the deprecated commands from v1.x
vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

local servers = { 'clangd' }

EOF

" Copilot "
let g:copilot_no_tab_map = v:true
imap <silent><script><expr> <Tab> copilot#Accept("\<Tab>")

" Nvim Tree "
NvimTreeOpen

" Coq "
let g:coq_settings = { 'auto_start': v:true }

set nocompatible
set clipboard=unnamedplus

" Numbers "
set number relativenumber
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set nofoldenable
