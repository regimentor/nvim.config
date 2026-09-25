-- Built-in commands use langmap; plugin mappings are handled by Langmapper.
-- Text entered in Insert mode and searches stays in the selected language.
vim.opt.langmap = [[ё`,йq,цw,уe,кr,еt,нy,гu,шi,щo,зp,х[,ъ],фa,ыs,вd,аf,пg,рh,оj,лk,дl,ж\;,э',яz,чx,сc,мv,иb,тn,ьm,б\,,ю.,Ё~,ЙQ,ЦW,УE,КR,ЕT,НY,ГU,ШI,ЩO,ЗP,Х{,Ъ},ФA,ЫS,ВD,АF,ПG,РH,ОJ,ЛK,ДL,Ж:,Э\",ЯZ,ЧX,СC,МV,ИB,ТN,ЬM,Б<,Ю>]]
vim.opt.langremap = false

vim.pack.add({
    { src = 'https://github.com/Wansmer/langmapper.nvim' },
})

require('langmapper').setup({
    -- Include completion and Copilot shortcuts registered in Insert mode.
    disable_hack_modes = {},
    default_layout = [[~QWERTYUIOP{}|ASDFGHJKL:"ZXCVBNM<>?`qwertyuiop[]asdfghjkl;'zxcvbnm,./!@#$%^&*()]],
    layouts = {
        ru = {
            id = 'ru',
            layout = [[ЁЙЦУКЕНГШЩЗХЪ/ФЫВАПРОЛДЖЭЯЧСМИТЬБЮ,ёйцукенгшщзхъфывапролджэячсмитьбю.!"№;%:?*()]],
        },
    },
    os = {
        Linux = {
            -- Shared punctuation needs the active layout to select its command.
            get_current_layout_id = function()
                if not vim.env.HYPRLAND_INSTANCE_SIGNATURE or vim.fn.executable('hyprctl') == 0 then
                    return
                end
                local result = vim.system({ 'hyprctl', '-j', 'devices' }):wait(200)
                if result.code ~= 0 then
                    return
                end
                local ok, devices = pcall(vim.json.decode, result.stdout)
                if not ok or type(devices) ~= 'table' then
                    return
                end
                for _, keyboard in ipairs(devices.keyboards or {}) do
                    if keyboard.main then
                        local layouts = vim.split(keyboard.layout, ',', { plain = true })
                        return layouts[(keyboard.active_layout_index or 0) + 1]
                    end
                end
            end,
        },
    },
})
