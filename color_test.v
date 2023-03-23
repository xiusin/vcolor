module vcolor

fn test_color() {
	mut color := new(Attribute.bg_hi_yellow, Attribute.bold, Attribute.underline)
	color.print('hello world')
	white('white string')
	magenta('magenta string')
	cyan('cyan string')
	red('red string')
	yellow('yellow string')
	green('green string')
	black('black string')
	blue('blue string')
	hi_white('white string')
	hi_magenta('magenta string')
	hi_cyan('cyan string')
	hi_red('red string')
	hi_yellow('yellow string')
	hi_green('green string')
	hi_black('black string')
	hi_blue('blue string')

	println(hi_green_string('hi_blue_string'))
}
