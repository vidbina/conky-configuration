-- https://github.com/brndnmtthws/conky/wiki/Using-Lua-scripts-in-conky:-How-does-a-lua-script-work
--this is a lua script for use in conky
require 'cairo'

function conky_main()
    if conky_window == nil then
        return
    end
    local cs = cairo_xlib_surface_create(conky_window.display,
                                         conky_window.drawable,
                                         conky_window.visual,
                                         conky_window.width,
                                         conky_window.height)
    cr = cairo_create(cs)
    local updates=tonumber(conky_parse('${updates}'))

    font="Mono"
    font_size=12
    text="hello world"
    xpos,ypos=100,100
    red,green,blue,alpha=1,1,1,1
    font_slant=CAIRO_FONT_SLANT_NORMAL
    font_face=CAIRO_FONT_WEIGHT_NORMAL

    cairo_select_font_face (cr, font, font_slant, font_face)
    cairo_set_font_size (cr, font_size)
    cairo_set_source_rgba (cr,red,green,blue,alpha)

    -- hello world
    cairo_move_to (cr,xpos,ypos);
    cairo_show_text (cr,text)
    cairo_stroke (cr)

    if updates>5 then
        print ("hello world")
    end
    cairo_destroy(cr)
    cairo_surface_destroy(cs)
    cr=nil
end
