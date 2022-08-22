local present, fzf = pcall(require, "fzf-lua")

if not present then
  return
end

fzf.register_ui_select()

local options = {

  fzf_opts = {
    ['--layout'] = 'default',
    ['--padding'] = '3%,1%'
  },

  winopts = {
    fullscreen = false
  },

  previewers = {
    man = {
      cmd = "man %s | col -bx",
    }
  },

  files = {
    previewer = "bat_native",
    file_icons = true,
    color_icons = false,
    winopts = {
      fullscreen = true
    },

  },
  oldfiles = {
    color_icons = false,
  },

  grep = {
    previewer = "bat_native",
    file_icons = false,
    color_icons = false,
    winopts = {
      fullscreen = true
    },
  },

  buffers = {
    color_icons = false
  },

  lines = {
    color_icons = false
  },

  git = {
    status = {
      preview_pager = "delta --width=$FZF_PREVIEW_COLUMNS",
    },

    files = {
      color_icons = false,
      winopts = {
        fullscreen = true
      },
    }
  },
}

fzf.setup(options)
