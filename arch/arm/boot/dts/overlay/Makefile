# SPDX-License-Identifier: GPL-2.0
dtbo-$(CONFIG_ARCH_ROCKCHIP) += \
	rockchip-ds1307.dtbo	\
	rockchip-i2c1.dtbo	\
	rockchip-i2c4.dtbo	\
	rockchip-spi0.dtbo	\
	rockchip-spi2.dtbo	\
	rockchip-spidev0.dtbo	\
	rockchip-spidev2.dtbo	\
	rockchip-uart1.dtbo	\
	rockchip-uart2.dtbo	\
	rockchip-uart3.dtbo	\
	rockchip-uart4.dtbo	\
	rockchip-w1-gpio.dtbo

scr-$(CONFIG_ARCH_ROCKCHIP) += \
       rockchip-fixup.scr

dtbotxt-$(CONFIG_ARCH_ROCKCHIP) += \
       README.rockchip-overlays

targets += $(dtbo-y) $(scr-y) $(dtbotxt-y)

always         := $(dtbo-y) $(scr-y) $(dtbotxt-y)
clean-files    := *.dtbo *.scr

