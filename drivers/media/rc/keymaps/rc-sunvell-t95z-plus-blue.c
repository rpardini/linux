// SPDX-License-Identifier: GPL-2.0+
/*
 * Copyright (c) 2026 Ricardo Pardini <ricardo@pardini.net>
 */

#include <media/rc-map.h>
#include <linux/module.h>

/*
 * Keytable for the remote shipped with some Sunvell T95Z Plus units: blue
 * D-pad, blue TV control block along the top, and "RO3 UM-4" moulded inside
 * the battery compartment.
 *
 * This is not the remote handled by rc-sunvell-t95z-plus, which uses NEC
 * address 0xdf. This one uses NEC address 0x01 and has LED and KD keys where
 * the other has TV and KODI, so the two keytables share no scancodes.
 *
 * The blue block at the top drives the TV rather than the box. Those keys are
 * learning keys; the codes below are what they send before being taught
 * anything.
 */

static struct rc_map_table sunvell_t95z_plus_blue[] = {
	{ 0x0002, KEY_VOLUMEUP },	/* blue TV VOL+ */
	{ 0x0100, KEY_MENU },
	{ 0x0101, KEY_0 },
	{ 0x0104, KEY_9 },
	{ 0x0105, KEY_8 },
	{ 0x0108, KEY_6 },
	{ 0x0109, KEY_5 },
	{ 0x010c, KEY_3 },
	{ 0x010d, KEY_2 },
	{ 0x010f, KEY_LIGHTS_TOGGLE },	/* LED */
	{ 0x0110, KEY_VOLUMEDOWN },
	{ 0x0111, KEY_HOME },
	{ 0x0113, KEY_ENTER },		/* OK */
	{ 0x0116, KEY_UP },
	{ 0x0118, KEY_VOLUMEUP },
	{ 0x0119, KEY_BACK },
	{ 0x011a, KEY_DOWN },
	{ 0x0140, KEY_POWER },
	{ 0x0141, KEY_WWW },		/* globe */
	{ 0x0142, KEY_BACKSPACE },
	{ 0x0143, KEY_FAVORITES },	/* KD */
	{ 0x0146, KEY_7 },
	{ 0x014a, KEY_4 },
	{ 0x014b, KEY_PREVIOUS },
	{ 0x014c, KEY_INFO },		/* mouse mode */
	{ 0x014e, KEY_1 },
	{ 0x014f, KEY_NEXT },
	{ 0x0150, KEY_RIGHT },
	{ 0x0151, KEY_LEFT },
	{ 0x01f1, KEY_POWER2 },		/* blue TV power */
	{ 0x01f2, KEY_SWITCHVIDEOMODE },/* blue TV source */
	{ 0x01f3, KEY_MUTE },		/* blue TV mute */
	{ 0x01f4, KEY_VOLUMEDOWN },	/* blue TV VOL- */
};

static struct rc_map_list sunvell_t95z_plus_blue_map = {
	.map = {
		.scan     = sunvell_t95z_plus_blue,
		.size     = ARRAY_SIZE(sunvell_t95z_plus_blue),
		.rc_proto = RC_PROTO_NEC,
		.name     = RC_MAP_SUNVELL_T95Z_PLUS_BLUE,
	}
};

static int __init init_rc_map_sunvell_t95z_plus_blue(void)
{
	return rc_map_register(&sunvell_t95z_plus_blue_map);
}

static void __exit exit_rc_map_sunvell_t95z_plus_blue(void)
{
	rc_map_unregister(&sunvell_t95z_plus_blue_map);
}

module_init(init_rc_map_sunvell_t95z_plus_blue)
module_exit(exit_rc_map_sunvell_t95z_plus_blue)

MODULE_DESCRIPTION("Sunvell T95Z Plus (blue RO3 UM-4) remote controller keytable");
MODULE_LICENSE("GPL");
MODULE_AUTHOR("Ricardo Pardini <ricardo@pardini.net>");
