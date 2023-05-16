<template>
  <div style="width: 100%; height: 100%">
    <video
      v-if="!expired"
      style="
        background: black;
        object-fit: fill;
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        max-height: 100%;
      "
      muted="muted"
      autobuffer="autobuffer"
      autoplay="autoplay"
      loop="loop"
    >
      <source :src="file" type="video/mp4" />
    </video>
  </div>
</template>

<script>
import { VideoWidget } from "models/video_widget.model";
export default {
  props: {
    widget: { type: VideoWidget, required: true },
  },
  computed: {
    file() {
      return this.widget.attachment.file;
    },
    expired() {
      return this.widget.attachment.expired;
    },
  },
};
</script>

<style>
</style>