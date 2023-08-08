<template>
  <div style="width: 100%; height: 100%">
    <img v-if="!expired" :src="file" style="position: absolute; width: 100%; max-height: 100%; top: 0; left: 0" />
  </div>
</template>

<script>
import { ImageWidget } from "models/image_widget.model";
export default {
  props: {
    widget: { type: ImageWidget, required: true },
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

<style></style>