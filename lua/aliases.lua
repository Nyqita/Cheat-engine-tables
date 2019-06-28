-- Globals
is_ready = false
ready_state = nil
matches = true
debug_verbosity = 0
module_address = 0
base_mem = 0
allow_requires = false

s_en = "[Enable]\n"
s_dis = "[Disable]\n"
s_lua = "{$lua}\n"
s_asm = "{$asm}\n"

-- Aliases
dp = debug_print
tbs = to_byte_string
lcm = lazy_child_maker
lcd = lazy_child_deleter
lwt = lazy_write_timer
hx = to_hex_string
nb = number_bases
ps = string.pstring
