-- https://github.com/brndnmtthws/conky/wiki/Using-Lua-scripts-in-conky:-How-does-a-lua-script-work
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

    cpu_perc=5*tonumber(conky_parse("${cpu cpu0}"))

    -- hello world
    font="Mono"
    font_size=12
    text="cpu: "..cpu_perc
    xpos,ypos=100,100
    red,green,blue,alpha=1,1,1,1
    font_slant=CAIRO_FONT_SLANT_NORMAL
    font_face=CAIRO_FONT_WEIGHT_NORMAL

    cairo_select_font_face (cr, font, font_slant, font_face)
    cairo_set_font_size (cr, font_size)
    cairo_set_source_rgba (cr,red,green,blue,alpha)

    cairo_move_to (cr,xpos,ypos);
    cairo_show_text (cr,text)

    -- print line
    line_width=2
    line_cap=CAIRO_LINE_CAP_BUTT
    red,green,blue,alpha=1,1,1,1
    startx=100
    starty=100
    endx=startx+cpu_perc
    endy=starty

    cairo_set_line_width (cr,line_width)
    cairo_set_line_cap  (cr, line_cap)
    cairo_set_source_rgba (cr,red,green,blue,alpha)
    cairo_move_to (cr,startx,starty)
    cairo_line_to(cr, endx, endy)

    -- rect
    top_left_x=20
    top_left_y=20
    rec_width=100
    rec_height=50

    cairo_rectangle (cr, top_left_x, top_left_y, rec_width, rec_height)

    cairo_stroke(cr)

--    if updates>5 then
--        print(text)
--    end

    cairo_destroy(cr)
    cairo_surface_destroy(cs)
    cr=nil
end
