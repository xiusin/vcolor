module vcolor

import os
import io

const escape = '\x1b'

[noinit]
struct Color {
mut:
	colorable bool
	params    []Attribute
	writer    io.Writer
}

pub enum Attribute {
	reset = 0
	bold
	faint
	italic
	underline
	blink_slow
	blink_rapid
	reverse_video
	concealed
	crossed_out
	fg_black = 30
	fg_red
	fg_green
	fg_yellow
	fg_blue
	fg_magenta
	fg_cyan
	fg_white
	bg_black = 40
	bg_red
	bg_green
	bg_yellow
	bg_blue
	bg_magenta
	bg_cyan
	bg_white
	fg_hi_black = 90
	fg_hi_red
	fg_hi_green
	fg_hi_yellow
	fg_hi_blue
	fg_hi_magenta
	fg_hi_cyan
	fg_hi_white
	bg_hi_black = 100
	bg_hi_red
	bg_hi_green
	bg_hi_yellow
	bg_hi_blue
	bg_hi_magenta
	bg_hi_cyan
	bg_hi_white
}

pub fn new(attrs ...Attribute) &Color {
	color := &Color{
		params: attrs
		colorable: os.getenv('NO_COLOR') == ''
		writer: os.stdout()
	}
	return color
}

pub fn (mut color Color) set_writer(writer io.Writer) {
	color.writer = writer
}

// add is used to chain SGR parameters. Use as many as parameters to combine and create custom color objects. Example: add(.fg_red, .underline).
pub fn (mut color Color) add(attrs ...Attribute) {
	color.params << attrs
}

// enable_color enables the color output.
pub fn (mut color Color) enable_color() {
	color.colorable = true
}

// disable_color disables the color output.
pub fn (mut color Color) disable_color() {
	color.colorable = false
}

// colorable
pub fn (mut color Color) colorable() bool {
	return color.colorable
}

pub fn (mut color Color) sprint(format string, a ...voidptr) string {
	mut params := [format]
	for key in a {
		params << key.str()
	}
	return color.wrap(params.join(' '))
}

pub fn (mut color Color) print(format string, a ...voidptr) {
	color.writer.write(color.sprint(format, ...a).bytes()) or {}
}

pub fn (mut color Color) println(format string, a ...voidptr) {
	mut format_new_line := format
	if !format.ends_with('\n') {
		format_new_line += '\n'
	}
	color.print(format_new_line, ...a)
}

fn (mut color Color) wrap(s string) string {
	if color.colorable() {
		return color.format() + s + color.unformat()
	}
	return s
}

fn (mut color Color) format() string {
	return '${vcolor.escape}[${color.sequence()}m'
}

fn (mut color Color) unformat() string {
	return '${vcolor.escape}[${int(Attribute.reset).str()}m'
}

// sequence
fn (mut color Color) sequence() string {
	mut formats := []string{cap: color.params.len}
	for _, v in color.params {
		formats << int(v).str()
	}
	return formats.join(';')
}

pub fn color_string(format string, attr Attribute, a ...voidptr) string {
	mut c := new(attr)
	return c.sprint(format)
}

fn color_print(format string, attr Attribute, a ...voidptr) {
	mut c := new(attr)
	c.println(format)
}

pub fn red(format string) {
	color_print(format, Attribute.fg_red)
}

pub fn green(format string) {
	color_print(format, Attribute.fg_green)
}

pub fn cyan(format string) {
	color_print(format, Attribute.fg_cyan)
}

pub fn black(format string) {
	color_print(format, Attribute.fg_black)
}

pub fn yellow(format string) {
	color_print(format, Attribute.fg_yellow)
}

pub fn blue(format string) {
	color_print(format, Attribute.fg_blue)
}

pub fn magenta(format string) {
	color_print(format, Attribute.fg_magenta)
}

pub fn white(format string) {
	color_print(format, Attribute.fg_white)
}

pub fn hi_red(format string) {
	color_print(format, Attribute.fg_hi_red)
}

pub fn hi_green(format string) {
	color_print(format, Attribute.fg_hi_green)
}

pub fn hi_cyan(format string) {
	color_print(format, Attribute.fg_hi_cyan)
}

pub fn hi_black(format string) {
	color_print(format, Attribute.fg_hi_black)
}

pub fn hi_yellow(format string) {
	color_print(format, Attribute.fg_hi_yellow)
}

pub fn hi_blue(format string) {
	color_print(format, Attribute.fg_hi_blue)
}

pub fn hi_magenta(format string) {
	color_print(format, Attribute.fg_hi_magenta)
}

pub fn hi_white(format string) {
	color_print(format, Attribute.fg_hi_white)
}

pub fn red_string(format string) string {
	return color_string(format, Attribute.fg_red)
}

pub fn green_string(format string) string {
	return color_string(format, Attribute.fg_green)
}

pub fn cyan_string(format string) string {
	return color_string(format, Attribute.fg_cyan)
}

pub fn black_string(format string) string {
	return color_string(format, Attribute.fg_black)
}

pub fn yellow_string(format string) string {
	return color_string(format, Attribute.fg_yellow)
}

pub fn blue_string(format string) string {
	return color_string(format, Attribute.fg_blue)
}

pub fn magenta_string(format string) string {
	return color_string(format, Attribute.fg_magenta)
}

pub fn white_string(format string) string {
	return color_string(format, Attribute.fg_white)
}

pub fn hi_red_string(format string) string {
	return color_string(format, Attribute.fg_hi_red)
}

pub fn hi_green_string(format string) string {
	return color_string(format, Attribute.fg_hi_green)
}

pub fn hi_cyan_string(format string) string {
	return color_string(format, Attribute.fg_hi_cyan)
}

pub fn hi_black_string(format string) string {
	return color_string(format, Attribute.fg_hi_black)
}

pub fn hi_yellow_string(format string) string {
	return color_string(format, Attribute.fg_hi_yellow)
}

pub fn hi_blue_string(format string) string {
	return color_string(format, Attribute.fg_hi_blue)
}

pub fn hi_magenta_string(format string) string {
	return color_string(format, Attribute.fg_hi_magenta)
}

pub fn hi_white_string(format string) string {
	return color_string(format, Attribute.fg_hi_white)
}
