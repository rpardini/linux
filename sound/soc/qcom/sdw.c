// SPDX-License-Identifier: GPL-2.0
// Copyright (c) 2018, Linaro Limited.
// Copyright (c) 2018, The Linux Foundation. All rights reserved.

#include <linux/module.h>
#include <sound/soc.h>
#include <sound/pcm_params.h>
#include "qdsp6/q6afe.h"
#include "sdw.h"

static unsigned int tdm_slot_offset[8] = {0, 4, 8, 12, 16, 20, 24, 28};

int qcom_snd_sdw_prepare(struct snd_pcm_substream *substream,
			 struct sdw_stream_runtime *sruntime,
			 bool *stream_prepared)
{
	struct snd_soc_pcm_runtime *rtd = substream->private_data;
	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
	int ret;

	if (!sruntime)
		return 0;

	switch (cpu_dai->id) {
	case WSA_CODEC_DMA_RX_0:
	case WSA_CODEC_DMA_RX_1:
	case RX_CODEC_DMA_RX_0:
	case RX_CODEC_DMA_RX_1:
	case TX_CODEC_DMA_TX_0:
	case TX_CODEC_DMA_TX_1:
	case TX_CODEC_DMA_TX_2:
	case TX_CODEC_DMA_TX_3:
		break;
	default:
		return 0;
	}

	if (*stream_prepared)
		return 0;

	ret = sdw_prepare_stream(sruntime);
	if (ret)
		return ret;

	/**
	 * NOTE: there is a strict hw requirement about the ordering of port
	 * enables and actual WSA881x PA enable. PA enable should only happen
	 * after soundwire ports are enabled if not DC on the line is
	 * accumulated resulting in Click/Pop Noise
	 * PA enable/mute are handled as part of codec DAPM and digital mute.
	 */

	ret = sdw_enable_stream(sruntime);
	if (ret) {
		sdw_deprepare_stream(sruntime);
		return ret;
	}
	*stream_prepared  = true;

	return ret;
}
EXPORT_SYMBOL_GPL(qcom_snd_sdw_prepare);

static int qcom_tdm_snd_hw_params(struct snd_pcm_substream *substream,
					struct snd_pcm_hw_params *params)
{
	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);

	int ret = 0;
	int channels, slot_width;

	switch (params_format(params)) {
	case SNDRV_PCM_FORMAT_S16_LE:
	  slot_width = 32;
	  break;
	default:
	  dev_err(rtd->dev, "%s: invalid param format 0x%x\n",
	          __func__, params_format(params));
	  return -EINVAL;
	}

	channels = params_channels(params);
	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
	  ret = snd_soc_dai_set_tdm_slot(cpu_dai, 0, 0x03,
	                  8, slot_width);
	  if (ret < 0) {
	          dev_err(rtd->dev, "%s: failed to set tdm slot, err:%d\n",
	                          __func__, ret);
	          goto end;
	  }

	  ret = snd_soc_dai_set_channel_map(cpu_dai, 0, NULL,
	                  channels, tdm_slot_offset);
	  if (ret < 0) {
	          dev_err(rtd->dev, "%s: failed to set channel map, err:%d\n",
	                          __func__, ret);
	          goto end;
	  }
	} else {
	   ret = snd_soc_dai_set_tdm_slot(cpu_dai, 0xf, 0,
	                    8, slot_width);
	   if (ret < 0) {
	      dev_err(rtd->dev, "%s: failed to set tdm slot, err:%d\n",
	              __func__, ret);
	      goto end;
	    }

	   ret = snd_soc_dai_set_channel_map(cpu_dai, channels,
	                    tdm_slot_offset, 0, NULL);
	   if (ret < 0) {
	      dev_err(rtd->dev, "%s: failed to set channel map, err:%d\n",
	              __func__, ret);
	      goto end;
	   }
	}

end:
	return ret;
}

int qcom_snd_sdw_hw_params(struct snd_pcm_substream *substream,
			   struct snd_pcm_hw_params *params,
			   struct sdw_stream_runtime **psruntime)
{
	struct snd_soc_pcm_runtime *rtd = substream->private_data;
	struct snd_soc_dai *codec_dai;
	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
	struct sdw_stream_runtime *sruntime;
	int i;

	switch (cpu_dai->id) {
	case WSA_CODEC_DMA_RX_0:
	case RX_CODEC_DMA_RX_0:
	case RX_CODEC_DMA_RX_1:
	case TX_CODEC_DMA_TX_0:
	case TX_CODEC_DMA_TX_1:
	case TX_CODEC_DMA_TX_2:
	case TX_CODEC_DMA_TX_3:
		for_each_rtd_codec_dais(rtd, i, codec_dai) {
			sruntime = snd_soc_dai_get_stream(codec_dai, substream->stream);
			if (sruntime != ERR_PTR(-ENOTSUPP))
				*psruntime = sruntime;
		}
		break;
	case TERTIARY_TDM_RX_0:
	case TERTIARY_TDM_TX_0:
		qcom_tdm_snd_hw_params(substream, params);
		break;
	}

	return 0;

}
EXPORT_SYMBOL_GPL(qcom_snd_sdw_hw_params);

int qcom_snd_sdw_hw_free(struct snd_pcm_substream *substream,
			 struct sdw_stream_runtime *sruntime, bool *stream_prepared)
{
	struct snd_soc_pcm_runtime *rtd = substream->private_data;
	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);

	switch (cpu_dai->id) {
	case WSA_CODEC_DMA_RX_0:
	case WSA_CODEC_DMA_RX_1:
	case RX_CODEC_DMA_RX_0:
	case RX_CODEC_DMA_RX_1:
	case TX_CODEC_DMA_TX_0:
	case TX_CODEC_DMA_TX_1:
	case TX_CODEC_DMA_TX_2:
	case TX_CODEC_DMA_TX_3:
		if (sruntime && *stream_prepared) {
			sdw_disable_stream(sruntime);
			sdw_deprepare_stream(sruntime);
			*stream_prepared = false;
		}
		break;
	default:
		break;
	}

	return 0;
}
EXPORT_SYMBOL_GPL(qcom_snd_sdw_hw_free);
MODULE_LICENSE("GPL v2");
