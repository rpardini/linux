// SPDX-License-Identifier: GPL-2.0+
// rc-rk322x-tvbox.c - Keytable for rk322x generic tv box remote controller
//
// keymap imported from ir-keymaps.c
//
// Copyright (c) 2022 Paolo Sabatino

#include <media/rc-map.h>
#include <linux/module.h>

/*

*/

static struct rc_map_table rk322x_tvbox[] = {

	{ 0x40400d, KEY_ENTER },
	{ 0x40404d, KEY_POWER },
	{ 0x40401e, KEY_PREVIOUSSONG },
	{ 0x40401f, KEY_NEXTSONG },
	{ 0x404001, KEY_1 },
	{ 0x404002, KEY_2 },
	{ 0x404003, KEY_3 },
	{ 0x404004, KEY_4 },
	{ 0x404005, KEY_5 },
	{ 0x404006, KEY_6 },
	{ 0x404007, KEY_7 },
	{ 0x404008, KEY_8 },
	{ 0x404009, KEY_9 },
	{ 0x404000, KEY_0 },
	{ 0x40400c, KEY_BACKSPACE },
	{ 0x404044, KEY_F6 },
	{ 0x40401a, KEY_HOME },
	{ 0x404042, KEY_BACK },
	{ 0x404045, KEY_MENU },
	{ 0x40400f, KEY_TEXT },
	{ 0x404010, KEY_LEFT },
	{ 0x404011, KEY_RIGHT },
	{ 0x40400e, KEY_DOWN },
	{ 0x40400b, KEY_UP },
	{ 0x40401c, KEY_VOLUMEDOWN },
	{ 0x404043, KEY_MUTE },
	{ 0x404015, KEY_VOLUMEUP },
	{ 0x404053, KEY_F1 },
	{ 0x40405b, KEY_F2 },
	{ 0x404057, KEY_F3 },
	{ 0x404054, KEY_F4 },

};

static struct rc_map_list rk322x_tvbox_map = {
	.map = {
		.scan     = rk322x_tvbox,
		.size     = ARRAY_SIZE(rk322x_tvbox),
		.rc_proto = RC_PROTO_NEC,	/* Legacy IR type */
		.name     = RC_MAP_RK322X_TVBOX,
	}
};

static int __init init_rc_map_rk322x_tvbox(void)
{
	return rc_map_register(&rk322x_tvbox_map);
}

static void __exit exit_rc_map_rk322x_tvbox(void)
{
	rc_map_unregister(&rk322x_tvbox_map);
}

module_init(init_rc_map_rk322x_tvbox)
module_exit(exit_rc_map_rk322x_tvbox)

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Paolo Sabatino");
